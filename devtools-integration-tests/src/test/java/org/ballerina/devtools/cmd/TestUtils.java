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
import java.net.URI;
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

    private static final String BALLERINA_HOME_DIR = "BALLERINA_HOME_DIR";
    private static final String BALLERINA_DEV_CENTRAL = "BALLERINA_DEV_CENTRAL";
    private static final PrintStream OUT = System.out;
    private static final Path TARGET_DIR = Paths.get(System.getProperty("target.dir"));
    private static final Path TEST_DISTRIBUTION_PATH = TARGET_DIR.resolve("test-distribution");

    public static String distributionName = "ballerina-" + MAVEN_VERSION;
    private static Path sourceDirectory;
    private static Path tempHomeDirectory;
    private static Map<String, String> envProperties;

    /**
     * Execute ballerina command.
     *
     * @param command The ballerina command to be executed.
     * @param args             The arguments to be passed to the build command.
     * @return inputream with log outputs
     * @throws IOException          Error executing build command.
     * @throws InterruptedException Interrupted error executing build command.
     */
    public static Path executeCommand1(String command, Path sourceDirectory, List<String> args) throws IOException, InterruptedException {
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
        process.waitFor();
        return sourceDirectory;
    }

    public static Path executeCommand(String command, List<String> args) throws IOException, InterruptedException {
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
        process.waitFor();
        return sourceDirectory;
    }

    /**
     * Provide user home directory based on command.
     *
     * @return user home directory
     */
    public static String getUserHome() {
        String userHome = System.getenv("HOME");
        if (userHome == null) {
            userHome = System.getProperty("user.home");
        }
        return userHome;
    }

    /**
     * Read the output of a given command.
     *
     * @return output of the executed command
     */
    public static String getOutput(URI pathURI) throws IOException {
        String output = "";
//        File file = new File(getUserHome() + File.separator
//                + "temp-" + new Timestamp(System.currentTimeMillis()).getTime() + ".sh");
        ProcessBuilder pb = new ProcessBuilder(pathURI.getPath());
        Process process = pb.start();
        InputStream inputStream = process.getInputStream();
        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
        String line;
        while ((line = reader.readLine()) != null) {
            output += line + "\n";
        }
        if (output.isEmpty()) {
            inputStream =  process.getErrorStream();
            reader = new BufferedReader(new InputStreamReader(inputStream));
            while ((line = reader.readLine()) != null) {
                output += line + "\n";
            }
        }
//        file.delete();
        return output;
    }

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

    public static InputStream executeCommand(String arg, String distributionName, List<String> args) throws
            IOException, InterruptedException {
        args.add(0, arg);
        Process process = getProcessBuilderResults(distributionName, sourceDirectory, args);
        return process.getErrorStream();
    }

    public static Path executeBuildCommand(Path sourceDirectory, List<String> args) throws IOException, InterruptedException {
        return executeCommand1("build", sourceDirectory, args);
    }

    public static Process getProcessBuilderResults(String distributionName, Path sourceDirectory, List<String> args)
            throws IOException, InterruptedException {

        args.add(0, TEST_DISTRIBUTION_PATH.resolve(distributionName).resolve("bin").resolve("bal").toString());
        OUT.println("Executing: " + StringUtils.join(args, ' '));
        ProcessBuilder pb = new ProcessBuilder(args);
        pb.directory(sourceDirectory.toFile());
        Process process = pb.start();
        int exitCode = process.waitFor();
        return process;
    }

    public static boolean executeBuild(String distributionName, Path sourceDirectory, List<String> args) throws
            IOException, InterruptedException {
        args.add(0, "build");
        args.add(0, TEST_DISTRIBUTION_PATH.resolve(distributionName).resolve("bin").resolve("bal").toString());
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
     * Execute ballerina build command.
     *
     * @param distributionName The name of the distribution.
     * @param args             The arguments to be passed to the build command.
     * @return True if build is successful, else false.
     * @throws IOException          Error executing build command.
     * @throws InterruptedException Interrupted error executing build command.
     */
    public static boolean executeNew(String distributionName, List<String> args) throws
            IOException, InterruptedException {
        args.add(0, "new");
        args.add(0, TEST_DISTRIBUTION_PATH.resolve(distributionName).resolve("bin").resolve("bal").toString());
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
     * Execute the given command.
     *
     * @param command command needs to be execute
     * @return output of the executed command
     */
//    public static String executeCommand(String command, Path projectPath) throws IOException {
//        String output = "";
//        File file = new File(getUserHome() + File.separator
//                + "temp-" + new Timestamp(System.currentTimeMillis()).getTime() + ".sh");
//        file.createNewFile();
//        file.setExecutable(true);
//        PrintWriter writer = new PrintWriter(file.getPath(), StandardCharsets.UTF_8);
//        writer.println(command);
//        writer.close();
//
//        ProcessBuilder pb = new ProcessBuilder(file.getPath());
//        Process process = pb.start();
//        InputStream inputStream = process.getInputStream();
//        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
//        String line;
//        while ((line = reader.readLine()) != null) {
//            output += line + "\n";
//        }
//        if (output.isEmpty()) {
//            inputStream =  process.getErrorStream();
//            reader = new BufferedReader(new InputStreamReader(inputStream));
//            while ((line = reader.readLine()) != null) {
//                output += line + "\n";
//            }
//        }
//        file.delete();
//        return output;
//    }

    public static Process executeCommand(String command, Path sourceDirectory, List<String> args)
            throws IOException, InterruptedException {
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
     * @param dirPath Path to directory for creating settings.toml.
     *
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
