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

package org.ballerina.projectapi;

import net.lingala.zip4j.ZipFile;
import net.lingala.zip4j.exception.ZipException;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;

import java.io.IOException;
import java.io.PrintStream;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

import static org.ballerina.projectapi.CentralTestUtils.BALLERINA_HOME_DIR;
import static org.ballerina.projectapi.CentralTestUtils.TEST_MODE_ACTIVE;

/**
 * Utility class for tests.
 */
public class TestUtils {

    private TestUtils() {
    }

    private static final PrintStream OUT = System.out;
    private static final Path TARGET_DIR = Paths.get(System.getProperty("target.dir"));
    private static final Path TEST_DISTRIBUTION_PATH = TARGET_DIR.resolve("test-distribution");
    public static final Path MAVEN_VERSION = Paths.get(System.getProperty("maven.version"));
    public static final Path DISTRIBUTIONS_DIR = Paths.get(System.getProperty("distributions.dir"));
    public static final Path CODE_NAME = Paths.get(System.getProperty("code.name"));
    public static final String OUTPUT_CONTAIN_ERRORS = "build output contain errors:";
    public static final String DISTRIBUTION_FILE_NAME = "ballerina-" + MAVEN_VERSION + "-" + CODE_NAME;

    /**
     * Execute ballerina command.
     *
     * @param distributionName The name of the distribution.
     * @param sourceDirectory  The directory where the sources files are location.
     * @param args             The arguments to be passed to the build command.
     * @return inputream with log outputs
     * @throws IOException          Error executing build command.
     * @throws InterruptedException Interrupted error executing build command.
     */
    public static Process executeCommand(String command, String distributionName, Path sourceDirectory,
            List<String> args, Map<String, String> envProperties) throws IOException, InterruptedException {
        args.add(0, command);
        // Use platform-specific bal executable: on Windows use bal.bat, otherwise use bal
        String osName = System.getProperty("os.name");
        String balExecutable = "bal";
        if (osName != null && osName.toLowerCase().contains("win")) {
            balExecutable = "bal.bat";
        }
        args.add(0, TEST_DISTRIBUTION_PATH.resolve(distributionName).resolve("bin").resolve(balExecutable).toString());

        OUT.println("Executing: " + StringUtils.join(args, ' '));

        ProcessBuilder pb = new ProcessBuilder(args);

        // Add env variables
        if (envProperties != null) {
            Map<String, String> env = pb.environment();
            for (Map.Entry<String, String> entry : envProperties.entrySet()) {
                env.put(entry.getKey(), entry.getValue());
            }
        }

        pb.directory(sourceDirectory.toFile());
        Process process = pb.start();
        int exitCode = process.waitFor();
        return process;
    }

    public static Process executeBuildCommand(String distributionName, Path sourceDirectory,
            List<String> args, Map<String, String> envProperties) throws IOException, InterruptedException {
        return executeCommand("build", distributionName, sourceDirectory, args, envProperties);
    }

    public static Process executePackCommand(String distributionName, Path sourceDirectory,
            List<String> args, Map<String, String> envProperties) throws IOException, InterruptedException {
        return executeCommand("pack", distributionName, sourceDirectory, args, envProperties);
    }

    public static Process executePushCommand(String distributionName, Path sourceDirectory,
            List<String> args, Map<String, String> envProperties) throws IOException, InterruptedException {
        return executeCommand("push", distributionName, sourceDirectory, args, envProperties);
    }

    public static Process executePullCommand(String distributionName, Path sourceDirectory,
            List<String> args, Map<String, String> envProperties) throws IOException, InterruptedException {
        return executeCommand("pull", distributionName, sourceDirectory, args, envProperties);
    }

    public static Process executeSearchCommand(String distributionName, Path sourceDirectory,
            List<String> args, Map<String, String> envProperties) throws IOException, InterruptedException {
        return executeCommand("search", distributionName, sourceDirectory, args, envProperties);
    }

    public static Process executeToolCommand(String distributionName, Path sourceDirectory,
            List<String> args, Map<String, String> envProperties) throws IOException, InterruptedException {
        return executeCommand("tool", distributionName, sourceDirectory, args, envProperties);
    }

    public static Process executeHelpCommand(String distributionName, Path sourceDirectory,
             List<String> args, Map<String, String> envProperties) throws IOException, InterruptedException {
        return executeCommand("help", distributionName, sourceDirectory, args, envProperties);
    }

    public static Process executeCleanCommand(String distributionName, Path sourceDirectory,
             List<String> args, Map<String, String> envProperties) throws IOException, InterruptedException {
        return executeCommand("clean", distributionName, sourceDirectory, args, envProperties);
    }

    public static Process executeNewCommand(String distributionName, Path sourceDirectory,
                                            List<String> args, Map<String, String> envProperties)
            throws IOException, InterruptedException {
        return executeCommand("new", distributionName, sourceDirectory, args, envProperties);
    }

    /**
     * Clean and setup the distribution.
     *
     * @throws IOException
     */
    static void setupDistributions() throws IOException {
        TestUtils.cleanDistribution();
        TestUtils.prepareDistribution(DISTRIBUTIONS_DIR.resolve(DISTRIBUTION_FILE_NAME + ".zip"));
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
     * Get environment variables and add ballerina_home as a env variable the tmp directory.
     *
     * @return env directory variable array
     */
    static Map<String, String> addEnvVariables(Map<String, String> envVariables, Path tempHomeDirectory) {
        envVariables.put(BALLERINA_HOME_DIR, tempHomeDirectory.toString());
        envVariables.put(TEST_MODE_ACTIVE, "true");
        return envVariables;
    }
}
