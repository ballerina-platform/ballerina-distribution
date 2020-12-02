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

    final static String baloGlob = "glob:**/*.balo";
    final static String jarGlob = "glob:**/*.jar";

    public static void main(String args[]) throws IOException {
        System.out.println("Building Distribution Repo ...");
        if (args.length != 1) {
            System.out.println("Invalid Inputs");
            System.exit(1);
        }
        Path repo = Paths.get(args[0]);

        // Find all balo files
        List<Path> balos = findBalos(repo);
        // Extract platform libs
        for (Path balo : balos) {
            extractPlatformLibs(balo);
        }
    }

    private static void extractPlatformLibs(Path path) throws IOException {
        Path packageRoot = path.getParent();
        Map<String, String> env = new HashMap<>();
        env.put("create", "true");
        // locate file system by using the syntax
        // defined in java.net.JarURLConnection
        URI uri = URI.create("jar:file:" + path.toAbsolutePath());
        try (FileSystem zipfs = FileSystems.newFileSystem(uri, env)) {
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

    static List<Path> findBalos(Path repo) throws IOException {
        List<Path> balos = new ArrayList<>();
        final PathMatcher pathMatcher = FileSystems.getDefault().getPathMatcher(baloGlob);
        Files.walkFileTree(repo, new SimpleFileVisitor<Path>() {
            @Override
            public FileVisitResult visitFile(Path path, BasicFileAttributes attrs) throws IOException {
                if (pathMatcher.matches(path)) {
                    balos.add(path);
                }
                return FileVisitResult.CONTINUE;
            }

            @Override
            public FileVisitResult visitFileFailed(Path file, IOException exc)
                    throws IOException {
                return FileVisitResult.CONTINUE;
            }
        });
        return balos;
    }

    private static void setFilePermission(Path filepath) {
        File file = filepath.toFile();
        file.setReadable(true, false);
        file.setWritable(true, true);
    }
}
