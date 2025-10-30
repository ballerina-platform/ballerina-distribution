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

import io.ballerina.projects.ProjectEnvironmentBuilder;
import io.ballerina.projects.bala.BalaProject;
import io.ballerina.projects.repos.TempDirCompilationCache;
import org.ballerinalang.docgen.docs.BallerinaDocGenerator;

import java.io.File;
import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.PathMatcher;
import java.nio.file.Paths;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.ArrayList;
import java.util.List;

/**
 * Utility class to build and populate distribution cache.
 *
 * @since 2.0.0
 */
public class DistRepoBuilder {

    final static String balaGlob = "glob:**/bala.json";
    final static String jarGlob = "glob:**/*.jar";
    final static String docGlob = "glob:**/api-docs.json";
    final static String MODULE_BALLERINAI_OBSERVE = "ballerinai" + File.separator +"observe";
    final static String OS = System.getProperty("os.name");

    public static void main(String args[]) throws Exception {
        System.out.println("Building Distribution Repo ...");
        if (args.length != 1) {
            System.out.println("Invalid Inputs");
            System.exit(1);
        }
        Path jBalToolsPath = Paths.get(args[0]);
        Path repo = jBalToolsPath.resolve("repo");
        System.setProperty("ballerina.home", jBalToolsPath.toString());

        // Find all bala files
        List<Path> balas = findBalas(repo.resolve("bala"));
        // Extract platform libs
        boolean valid = true;
        // The following list will contain existing docs from ballerina-lang repo
        List<Path> existingDocs = getExistingDocs(jBalToolsPath.resolve("docs"));
        for (Path bala : balas) {
            // skipping in windows since character length of path is greater than maximum in windows
            if (OS.contains("Windows")) {
                continue;
            }

            // skipping ballerinai-observe module since API docs are not generated for internal modules
            if (bala.toString().contains(MODULE_BALLERINAI_OBSERVE)) {
                continue;
            }
            generateDocsFromBala(bala, jBalToolsPath, existingDocs);
            // following function was put in to validate if bir and jar exists for packed balas
            valid = valid & validateCache(bala, repo);
        }
        if (!valid) {
            System.exit(1);
        }
    }

    private static List<Path> getExistingDocs(Path jBalToolsDocPath) throws IOException {
        List<Path> existingDocs = new ArrayList<>();
        final PathMatcher pathMatcher = FileSystems.getDefault().getPathMatcher(docGlob);
        Files.walkFileTree(jBalToolsDocPath, new SimpleFileVisitor<Path>() {
            @Override
            public FileVisitResult visitFile(Path path, BasicFileAttributes attrs) throws IOException {
                if (pathMatcher.matches(path)) {
                    Path relativePath = jBalToolsDocPath.relativize(path.getParent());
                    if (!relativePath.toString().equals("")) {
                        existingDocs.add(jBalToolsDocPath.relativize(path.getParent()));
                    }
                }
                return FileVisitResult.CONTINUE;
            }

            @Override
            public FileVisitResult visitFileFailed(Path file, IOException exc)
                    throws IOException {
                return FileVisitResult.CONTINUE;
            }
        });
        return existingDocs;
    }

    private static void generateDocsFromBala(Path balaPath, Path jBalToolsPath, List<Path> existingDocs) throws Exception {
        if (existingDocs.stream().noneMatch(path -> balaPath.toString().contains(path.toString()))) {
            try {
                ProjectEnvironmentBuilder defaultBuilder = ProjectEnvironmentBuilder.getDefaultBuilder();
                defaultBuilder.addCompilationCacheFactory(TempDirCompilationCache::from);
                BalaProject balaProject = BalaProject.loadProject(defaultBuilder, balaPath);
                BallerinaDocGenerator.generateAPIDocs(balaProject, jBalToolsPath.toString() + "/docs", true);
            } catch (Exception e) {
                e.printStackTrace();
                throw new Exception("Exception when generating docs from bala: " + balaPath.toString());
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
        Path jar = repo.resolve("cache").resolve(orgName).resolve(moduleName).resolve(version).resolve("java21")
                .resolve(getJarName(orgName, moduleName, version));
        if (!Files.exists(jar)) {
            System.out.println("Jar missing for package :" + orgName + "/" + moduleName);
            valid = false;
        }
        return valid;
    }

    static List<Path> findBalas(Path repo) throws IOException {
        List<Path> balas = new ArrayList<>();
        final PathMatcher pathMatcher = FileSystems.getDefault().getPathMatcher(balaGlob);
        Files.walkFileTree(repo, new SimpleFileVisitor<Path>() {
            @Override
            public FileVisitResult visitFile(Path path, BasicFileAttributes attrs) throws IOException {
                if (pathMatcher.matches(path)
                        && Files.notExists(path.getParent().resolve("tool/bal-tool.json"))) {
                    balas.add(path.getParent());
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

    private static String getJarName(String orgName, String moduleName, String version) {
        return orgName + '-' + moduleName + '-' + version + ".jar";
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
