/*
 *  Copyright (c) 2020, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 *  WSO2 Inc. licenses this file to you under the Apache License,
 *  Version 2.0 (the "License"); you may not use this file except
 *  in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing,
 *  software distributed under the License is distributed on an
 *  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *  KIND, either express or implied.  See the License for the
 *  specific language governing permissions and limitations
 *  under the License.
 */
package io.ballerina.dist;

import io.ballerina.projects.JBallerinaBackend;
import io.ballerina.projects.JvmTarget;
import io.ballerina.projects.Project;
import io.ballerina.projects.ProjectEnvironmentBuilder;
import io.ballerina.projects.PackageCompilation;
import io.ballerina.projects.bala.BalaProject;
import io.ballerina.projects.repos.FileSystemCache;
import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.nio.file.FileSystem;
import java.nio.file.FileSystems;
import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.PathMatcher;
import java.nio.file.Paths;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.StandardCopyOption;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Utility class to build and populate distribution cache.
 *
 * @since 2.0.0
 */
public class DistRepoBuilder {

    private final static String balaGlob = "glob:**/*.bala";
    private final static String jarGlob = "glob:**/*.jar";
    private static final String BALLERINA_HOME_KEY = "ballerina.home";

    public static void main(String args[]) throws IOException {
        System.out.println("Building Distribution Repo ...");
        if (args.length != 1) {
            System.out.println("Invalid Inputs");
            System.exit(1);
        }
        Path repo = Paths.get(args[0]);

        // Find all bala files
        List<Path> balas = findBalas(repo.resolve("bala"));
        // Extract platform libs
        boolean valid = true;
        for (Path bala : balas) {
            extractPlatformLibs(bala);
        }
        generateCaches(balas, repo);
        generateCaches(balas, repo);
    }

    private static void generateCaches(List<Path> balas, Path repo) {
        String[] stdLibs = {
                //Standard Libraries
                "ballerina-io",
                "ballerina-java.arrays",
                "ballerina-random",
                "ballerina-regex",
                "ballerina-runtime",
                "ballerina-task",
                "ballerina-time",
                "ballerina-url",
                "ballerina-xmldata",
                "ballerina-cache",
                "ballerina-crypto",
                "ballerina-os",
                "ballerina-xslt",
                "ballerina-log",
                "ballerina-reflect",
                "ballerina-uuid",
                "ballerina-auth",
                "ballerina-file",
                "ballerina-ftp",
                "ballerina-jwt",
                "ballerina-mime",
                "ballerina-nats",
                "ballerina-oauth2",
                "ballerina-stan",
                "ballerina-tcp",
                "ballerina-udp",
                "ballerina-email",
                "ballerina-http",
                "ballerina-grpc",
                "ballerinai-transaction",
                "ballerina-websocket",
                "ballerina-websub",
                "ballerina-websubhub",
                "ballerina-kafka",
                "ballerina-rabbitmq",
                "ballerina-sql",
                "ballerinax-java.jdbc",
                "ballerinax-mysql",
                "ballerina-graphql",
                "ballerina-graphql", // TODO : graphql had to generate twice
                //Extensions
//                "ballerinax-awslambda",
//                "ballerinax-azure_functions",
                "ballerina-docker",
//                "ballerinax-choreo",
//                "ballerinax-jaeger",
//                "ballerinax-prometheus",
//                "ballerinai-observe"
        };

        for (String stdLib : stdLibs) {
            for (Path bala : balas) {
                if (bala.getFileName().toString().contains(stdLib)) {
                    System.out.println("Generating " + stdLib);
                    try {
                        System.setProperty(BALLERINA_HOME_KEY, repo.getParent().toString());
                        ProjectEnvironmentBuilder defaultBuilder = ProjectEnvironmentBuilder.getDefaultBuilder();
                        defaultBuilder.addCompilationCacheFactory(new FileSystemCache.FileSystemCacheFactory(repo));
                        Project balaProject = BalaProject.loadProject(defaultBuilder, bala);
                        PackageCompilation packageCompilation = balaProject.currentPackage().getCompilation();
                        JBallerinaBackend.from(packageCompilation, JvmTarget.JAVA_11);
                    } catch (Error e) {
                        System.out.println("Error occurred " + stdLib);
                    }
                }
            }
        }
    }

    private static boolean validateCache(Path bala, Path repo) {
        boolean valid = true;
        String version = bala.getParent().getFileName().toString();
        String moduleName = bala.getParent().getParent().getFileName().toString();
        String orgName = bala.getParent().getParent().getParent().getFileName().toString();

        // Check if the bir exists
        Path bir = repo.resolve("cache").resolve(orgName).resolve(moduleName).resolve(version).resolve("bir")
                .resolve(moduleName + ".bir");
        if (!Files.exists(bir)) {
            System.out.println("Bir missing for package :" + orgName + "/" + moduleName);
            valid = false;
        }
        // Check if module jar exists
        Path jar = repo.resolve("cache").resolve(orgName).resolve(moduleName).resolve(version).resolve("java11")
                .resolve(moduleName + ".jar");
        if (!Files.exists(jar)) {
            System.out.println("Jar missing for package :" + orgName + "/" + moduleName);
           valid = false;
        }
        return valid;
    }

    private static void extractPlatformLibs(Path path) throws IOException {
        Path packageRoot = path.getParent();
        Map<String, String> env = new HashMap<>();
        env.put("create", "true");
        // locate file system by using the syntax
        // defined in java.net.JarURLConnection

        String filePath  = ("jar:file:" + path.toAbsolutePath().toString());
        if (isWindows()) {
            filePath = filePath.replace("\\", "/").replace("file:", "file:/");
        }
        try (FileSystem zipfs = FileSystems.newFileSystem(URI.create(filePath), env)) {
            final PathMatcher pathMatcher = FileSystems.getDefault().getPathMatcher(jarGlob);
            Files.walkFileTree(zipfs.getPath("/"), new SimpleFileVisitor<Path>() {
                @Override
                public FileVisitResult visitFile(Path from, BasicFileAttributes attrs) throws IOException {
                    if (pathMatcher.matches(from)) {
                        Path to = packageRoot.resolve(from.toString().replaceFirst("/", ""));
                        Files.createDirectories(to.getParent());
                        Files.copy(from, to, StandardCopyOption.REPLACE_EXISTING);
                        Files.delete(from);
                    }
                    return FileVisitResult.CONTINUE;
                }

                @Override
                public FileVisitResult visitFileFailed(Path file, IOException exc)
                        throws IOException {
                    return FileVisitResult.CONTINUE;
                }
            });
        }
        setFilePermission(path);
    }

    static List<Path> findBalas(Path repo) throws IOException {
        List<Path> balas = new ArrayList<>();
        final PathMatcher pathMatcher = FileSystems.getDefault().getPathMatcher(balaGlob);
        Files.walkFileTree(repo, new SimpleFileVisitor<Path>() {
            @Override
            public FileVisitResult visitFile(Path path, BasicFileAttributes attrs) throws IOException {
                if (pathMatcher.matches(path)) {
                    balas.add(path);
                }
                return FileVisitResult.CONTINUE;
            }

            @Override
            public FileVisitResult visitFileFailed(Path file, IOException exc)
                    throws IOException {
                return FileVisitResult.CONTINUE;
            }
        });
        return balas;
    }

    private static void setFilePermission(Path filepath) {
        File file = filepath.toFile();
        file.setReadable(true, false);
        file.setWritable(true, true);
    }

    private static boolean isWindows() {
        return System.getProperty("os.name").startsWith("Windows");
    }
}
