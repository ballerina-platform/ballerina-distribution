/*
 * Copyright (c) 2020, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package org.ballerinalang.distribution.utils;

import net.lingala.zip4j.ZipFile;
import net.lingala.zip4j.exception.ZipException;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Objects;

/**
 * Utility class for tests
 */
public class TestUtils {
    public static final PrintStream OUT = System.out;
    public static final Path TARGET_DIR = Paths.get(System.getProperty("target.dir"));
    public static final Path MAVEN_VERSION = Paths.get(System.getProperty("maven.version"));
    public static final Path SHORT_VERSION = Paths.get(System.getProperty("short.version"));
    public static final Path DISTRIBUTIONS_DIR = Paths.get(System.getProperty("distributions.dir"));
    public static final Path TEST_DISTRIBUTION_PATH = TARGET_DIR.resolve("test-distribution");
    public static final Path EXAMPLES_DIR = Paths.get(System.getProperty("examples.dir"));
    public static final String EXTENSTIONS_TO_BE_FILTERED_FOR_LINE_CHECKS = System.getProperty("line.check.extensions");

    /**
     * Log the output of an input stream.
     *
     * @param inputStream The stream.
     * @throws IOException Error reading the stream.
     */
    private static void logOutput(InputStream inputStream) throws IOException {
        try (BufferedReader br = new BufferedReader(new InputStreamReader(inputStream))) {
            br.lines().forEach(OUT::println);
        }
    }
    
    /**
     * Execute ballerina build command.
     *
     * @param distributionName The name of the distribution.
     * @param sourceDirectory  The directory where the sources files are location.
     * @param args             The arguments to be passed to the build command.
     * @return True if build is successful, else false.
     * @throws IOException          Error executing build command.
     * @throws InterruptedException Interrupted error executing build command.
     */
    public static boolean executeBuild(String distributionName, Path sourceDirectory, List<String> args) throws
            IOException, InterruptedException {
        args.add(0, "build");
        args.add(0, TEST_DISTRIBUTION_PATH.resolve(distributionName).resolve("bin").resolve("ballerina").toString());
        OUT.println("Executing: " + StringUtils.join(args, ' '));
        ProcessBuilder pb = new ProcessBuilder(args);
        pb.directory(sourceDirectory.toFile());
        Process process = pb.start();
        int exitCode = process.waitFor();
        logOutput(process.getInputStream());
        logOutput(process.getErrorStream());
        return exitCode == 0;
    }
    
    /**
     * Extracts a distribution to a temporary directory.
     *
     * @param distributionZipPath Path to the distribution.
     * @throws ZipException Error occurred when extracting.
     */
    public static void prepareDistribution(Path distributionZipPath) throws ZipException {
        OUT.println("Extracting: " + distributionZipPath.normalize());
        ZipFile zipFile = new ZipFile(distributionZipPath.toFile());
        zipFile.extractAll(TEST_DISTRIBUTION_PATH.toAbsolutePath().toString());
    }
    
    /**
     * Delete the temporary directory used to extract distributions.
     *
     * @throws IOException If temporary directory does not exists.
     */
    public static void cleanDistribution() throws IOException {
        FileUtils.deleteDirectory(TEST_DISTRIBUTION_PATH.toFile());
    }
    
    /**
     * Get the exact path to a test resource.
     *
     * @param resource Path of the file or directory.
     * @return The exact path of the file or directory.
     */
    public static Path getResource(Path resource) {
        File file = new File(TestUtils.class.getResource(resource.toString()).getFile());
        return file.toPath();
    }
    
    /**
     * Find the name of a file or directory that starts with a given name.
     *
     * @param dir     Directory to find in.
     * @param dirName The name of the file or directory to find.
     * @return Name of the file or directory if found. Else null.
     */
    public static String findFileOrDirectory(Path dir, String dirName) {
        FilenameFilter fileNameFilter = (dir1, name) -> name.startsWith(dirName);
        String[] fileNames = Objects.requireNonNull(dir.toFile().list(fileNameFilter));
        return fileNames.length > 0 ? fileNames[0] : null;
    }
}
