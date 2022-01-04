/*
 * Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

package org.ballerina.devtools.cmd;

import net.lingala.zip4j.ZipFile;
import net.lingala.zip4j.exception.ZipException;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.testng.Assert;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TestUtils {
    private TestUtils() {
    }

    public static final Path DISTRIBUTIONS_DIR = Paths.get(System.getProperty("distributions.dir"));
    public static final Path MAVEN_VERSION = Paths.get(System.getProperty("maven.version"));
    public static final Path CODE_NAME = Paths.get(System.getProperty("code.name"));

    private static final String BALLERINA_HOME_DIR = "BALLERINA_HOME_DIR";
    private static final String BALLERINA_DEV_CENTRAL = "BALLERINA_DEV_CENTRAL";
    private static final PrintStream OUT = System.out;
    private static final Path TARGET_DIR = Paths.get(System.getProperty("target.dir"));
    private static final Path TEST_DISTRIBUTION_PATH = TARGET_DIR.resolve("test-distribution");

    public static String distributionName = "ballerina-" + MAVEN_VERSION + "-" + CODE_NAME;
    private static Path sourceDirectory;
    private static Path tempHomeDirectory;
    private static Map<String, String> envProperties;

    public static String executeBuild(String distributionName, Path projectDir, List<String> args) throws
            IOException {
        args.add(0, "build");
        args.add(0, TEST_DISTRIBUTION_PATH.resolve(distributionName).resolve("bin").resolve("bal").toString());
        OUT.println("Executing: " + StringUtils.join(args, ' '));
        ProcessBuilder pb = new ProcessBuilder(args);
        pb.directory(projectDir.toFile());
        Process process = pb.start();
        InputStream inputStream = process.getInputStream();
        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
        String line;
        String output = "";
        while ((line = reader.readLine()) != null) {
            output += line + "\n";
        }
        if (output.isEmpty()) {
            inputStream = process.getErrorStream();
            reader = new BufferedReader(new InputStreamReader(inputStream));
            while ((line = reader.readLine()) != null) {
                output += line + "\n";
            }
        }
        return output;
    }

    /**
     * Execute ballerina build command.
     *
     * @param distributionName The name of the distribution.
     * @param args             The arguments to be passed to the build command.
     * @return True if build is successful, else false.
     * @throws IOException          Error executing build command.
     * @throws InterruptedException Interrupted error executing build command.
     */
    public static Path executeNew(String distributionName, List<String> args) throws
            IOException {
        args.add(0, "new");
        args.add(0, TEST_DISTRIBUTION_PATH.resolve(distributionName).resolve("bin").resolve("bal").toString());
        OUT.println("Executing: " + StringUtils.join(args, ' '));
        ProcessBuilder pb = new ProcessBuilder(args);
        pb.directory(sourceDirectory.toFile());
        Process process = pb.start();
        InputStream inputStream = process.getInputStream();
        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
        String line;
        String output = "";
        while ((line = reader.readLine()) != null) {
            output += line + "\n";
        }
        if (output.isEmpty()) {
            inputStream = process.getErrorStream();
            reader = new BufferedReader(new InputStreamReader(inputStream));
            while ((line = reader.readLine()) != null) {
                output += line + "\n";
            }
        }
        return sourceDirectory;
    }

    /**
     * Creates temporary directories.
     *
     * @throws ZipException Error occurred when extracting.
     */
    public static void createTempDirectories() throws IOException {
        sourceDirectory = Files.createTempDirectory("bal-test-integration-packaging-workspace-");
        envProperties = addEnvVariables(getEnvVariables());
        tempHomeDirectory = Files.createTempDirectory("bal-test-integration-packaging-home-");
        createSettingToml(tempHomeDirectory);
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
     * Create Settings.toml inside the home repository.
     *
     * @param dirPath Path to directory for creating settings.toml.
     * @throws IOException i/o exception when writing to file.
     */
    static void createSettingToml(Path dirPath) throws IOException {
        String content = "[central]\n accesstoken = \"" + getToken() + "\"";
        Files.write(dirPath.resolve("Settings.toml"), content.getBytes(), StandardOpenOption.CREATE,
                StandardOpenOption.TRUNCATE_EXISTING);
    }

    /**
     * Get token of ballerina-central-bot required to push the module.
     *
     * @return token required to push the module.
     */
    private static String getToken() {
        // staging and dev both has the same access token
        return System.getenv("devCentralToken");
    }

    /**
     * Get environment variables and add ballerina_home as a env variable the tmp directory.
     *
     * @return env directory variable array
     */
    static Map<String, String> getEnvVariables() {
        Map<String, String> envVarMap = System.getenv();
        Map<String, String> retMap = new HashMap<>();
        envVarMap.forEach(retMap::put);
        return retMap;
    }

    /**
     * Delete files inside directories.
     *
     * @throws IOException throw an exception if an issue occurs
     */
    static void deleteFiles() throws IOException {
        if (sourceDirectory == null && tempHomeDirectory == null) {
            return;
        }
        if (sourceDirectory != null) {
            Files.walk(sourceDirectory).sorted(Comparator.reverseOrder()).forEach(path -> {
                try {
                    Files.delete(path);
                } catch (IOException e) {
                    Assert.fail(e.getMessage(), e);
                }
            });
        }
        if (tempHomeDirectory != null) {
            Files.walk(tempHomeDirectory).sorted(Comparator.reverseOrder()).forEach(path -> {
                try {
                    Files.delete(path);
                } catch (IOException e) {
                    Assert.fail(e.getMessage(), e);
                }
            });
        }
    }

    /**
     * Get environment variables and add ballerina_home as a env variable the tmp directory.
     *
     * @return env directory variable array
     */
    public static Map<String, String> addEnvVariables(Map<String, String> envVariables) throws IOException {
        Path tempHomeDirectory = Files.createTempDirectory("bal-test-integration-packaging-home-");
        envVariables.put(BALLERINA_HOME_DIR, tempHomeDirectory.toString());
        envVariables.put(BALLERINA_DEV_CENTRAL, "true");
        return envVariables;
    }

    /**
     * Get executable jar path.
     *
     * @param projectPath project path
     * @param pkgName     package name
     * @return executable jar path
     */
    static Path getExecutableJarPath(Path projectPath, String pkgName) {
        return projectPath.resolve("target").resolve("bin").resolve(pkgName + ".jar");
    }
}
