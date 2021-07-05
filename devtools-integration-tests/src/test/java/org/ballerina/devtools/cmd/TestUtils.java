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

import java.io.IOException;
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

    static final String BALLERINA_HOME_DIR = "BALLERINA_HOME_DIR";
    static final String BALLERINA_DEV_CENTRAL = "BALLERINA_DEV_CENTRAL";
    public static final Path DISTRIBUTIONS_DIR = Paths.get(System.getProperty("distributions.dir"));

    private static final PrintStream OUT = System.out;
    private static final Path TARGET_DIR = Paths.get(System.getProperty("target.dir"));
    private static final Path TEST_DISTRIBUTION_PATH = TARGET_DIR.resolve("test-distribution");
    public static final Path MAVEN_VERSION = Paths.get(System.getProperty("maven.version"));

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
        args.add(0, TEST_DISTRIBUTION_PATH.resolve(distributionName).resolve("bin").resolve("bal").toString());

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

    public static Process executeNewCommand(String distributionName, Path sourceDirectory,
                                            List<String> args, Map<String, String> envProperties) throws IOException, InterruptedException {
        return executeCommand("new", distributionName, sourceDirectory, args, envProperties);
    }

    public static Process executeBuildCommand(String distributionName, Path sourceDirectory,
                                              List<String> args, Map<String, String> envProperties) throws IOException, InterruptedException {
        return executeCommand("build", distributionName, sourceDirectory, args, envProperties);
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
     * @throws IOException i/o exception when writing to file
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
     * @param dirPath directory path
     * @throws IOException throw an exception if an issue occurs
     */
    static void deleteFiles(Path dirPath) throws IOException {
        if (dirPath == null) {
            return;
        }
        Files.walk(dirPath).sorted(Comparator.reverseOrder()).forEach(path -> {
            try {
                Files.delete(path);
            } catch (IOException e) {
                Assert.fail(e.getMessage(), e);
            }
        });
    }

    /**
     * Get generate bala log.
     *
     * @param org      org name
     * @param pkgName  package name
     * @param platform platform name
     * @param version  package version
     * @return generate bala log
     */
    static String getGenerateBalaLog(String org, String pkgName, String platform, String version) {
        return "Creating bala\n" + "\ttarget/bala/" + org + "-" + pkgName + "-" + platform + "-" + version + ".bala";
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

    /**
     * Get executable jar path.
     *
     * @param projectPath project path
     * @param org         org name
     * @param pkgName     package name
     * @param platform    platform name
     * @param version     package version
     * @return bala path
     */
    static Path getBalaPath(Path projectPath, String org, String pkgName, String platform, String version) {
        return projectPath.resolve("target").resolve("bala")
                .resolve(org + "-" + pkgName + "-" + platform + "-" + version + ".bala");
    }
}
