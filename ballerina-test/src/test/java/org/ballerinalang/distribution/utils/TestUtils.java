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
import org.testng.Assert;

import java.io.BufferedReader;
import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.sql.Timestamp;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * Utility class for tests
 */
public class TestUtils {
    public static final PrintStream OUT = System.out;
    public static final Path TARGET_DIR = Paths.get(System.getProperty("target.dir"));
    public static final Path MAVEN_VERSION = Paths.get(System.getProperty("maven.version"));
    public static final Path SHORT_VERSION = Paths.get(System.getProperty("short.version"));
    public static final Path CODE_NAME = Paths.get(System.getProperty("code.name"));
    public static final String OPENAPI_VERSION = System.getProperty("openapi.version");
    public static final Path DISTRIBUTIONS_DIR = Paths.get(System.getProperty("distributions.dir"));
    public static final Path TEST_DISTRIBUTION_PATH = TARGET_DIR.resolve("test-distribution");
    public static final Path EXAMPLES_DIR = Paths.get(System.getProperty("examples.dir"));
    public static final String EXTENSTIONS_TO_BE_FILTERED_FOR_LINE_CHECKS = System.getProperty("line.check.extensions");
    public static final Path RESOURCES_PATH = TARGET_DIR.resolve("resources/test");
    private static final String SWAN_LAKE_KEYWORD = "swan-lake";
    public static final String WHITESPACE_PATTERN = "\\s+";
    private static String balFile = "bal";
    public static final String DISTRIBUTION_FILE_NAME = "ballerina-" + MAVEN_VERSION + "-" + CODE_NAME;
    public static final String OPENAPI_CMD = "openapi";
    public static final String GRAPHQL_CMD = "graphql";

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
        if (System.getProperty("os.name").startsWith("Windows")) {
            balFile = "bal.bat";
        }
        args.add(0, "build");
        args.add(0, TEST_DISTRIBUTION_PATH.resolve(distributionName).resolve("bin").resolve(balFile).toString());
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
     * Execute ballerina build command with openAPI annotation.
     *
     * @param distributionName The name of the distribution.
     * @param sourceDirectory  The directory where the sources files are location.
     * @param args             The arguments to be passed to the build command.
     * @return inputream with log outputs
     * @throws IOException          Error executing build command.
     * @throws InterruptedException Interrupted error executing build command.
     */
    public static InputStream executeOpenapiBuild(String distributionName, Path sourceDirectory, List<String> args) throws
            IOException, InterruptedException {
        args.add(0, "build");
        Process process = getProcessBuilderResults(distributionName, sourceDirectory, args);
        return process.getErrorStream();
    }

    /**
     * Execute bal grpc command with provided input
     *
     * @param distributionName The name of the distribution.
     * @param sourceDirectory  The directory where the sources files are located.
     * @param args             The arguments to be passed to the build command.
     * @return error stream from the `grpc` command as an `InputStream`
     * @throws IOException          Error executing build command.
     * @throws InterruptedException Interrupted error executing build command.
     */
    public static InputStream executeGrpcCommand(String distributionName, Path sourceDirectory, List<String> args,
                                                 boolean getError) throws
            IOException, InterruptedException {
        args.add(0, "grpc");
        Process process = getProcessBuilderResults(distributionName, sourceDirectory, args);
        process.waitFor();
        return getError ? process.getErrorStream() : process.getInputStream();
    }

    /**
     * Execute ballerina openapi command.
     *
     * @param distributionName The name of the distribution.
     * @param sourceDirectory  The directory where the sources files are location.
     * @param args             The arguments to be passed to the build command.
     * @return True if build is successful, else false.
     * @throws IOException          Error executing build command.
     * @throws InterruptedException Interrupted error executing build command.
     */
    public static boolean executeOpenAPI(String distributionName, Path sourceDirectory, List<String> args) throws
            IOException, InterruptedException {
        args.add(0, OPENAPI_CMD);
        Process process = getProcessBuilderResults(distributionName, sourceDirectory, args);
        int exitCode = process.waitFor();
        logOutput(process.getInputStream());
        logOutput(process.getErrorStream());
        return exitCode == 0;
    }

    /**
     * Execute ballerina graphql command.
     *
     * @param distributionName The name of the distribution.
     * @param sourceDirectory  The directory where the sources files are location.
     * @param args             The arguments to be passed to the build command.
     * @return True if build is successful, else false.
     * @throws IOException          Error executing build command.
     * @throws InterruptedException Interrupted error executing build command.
     */
    public static boolean executeGraphql(String distributionName, Path sourceDirectory, List<String> args) throws
            IOException, InterruptedException {
        args.add(0, GRAPHQL_CMD);
        Process process = getProcessBuilderResults(distributionName, sourceDirectory, args);
        int exitCode = process.waitFor();
        logOutput(process.getInputStream());
        logOutput(process.getErrorStream());
        return exitCode == 0;
    }

    /**
     *  Get Process from given arguments.
     * @param distributionName The name of the distribution.
     * @param sourceDirectory  The directory where the sources files are location.
     * @param args             The arguments to be passed to the build command.
     * @return process
     * @throws IOException          Error executing build command.
     * @throws InterruptedException Interrupted error executing build command.
     */
    public static Process getProcessBuilderResults(String distributionName, Path sourceDirectory, List<String> args)
            throws IOException, InterruptedException {
        
        if (System.getProperty("os.name").startsWith("Windows")) {
            balFile = "bal.bat";
        }
        args.add(0, TEST_DISTRIBUTION_PATH.resolve(distributionName).resolve("bin").resolve(balFile).toString());
        OUT.println("Executing: " + StringUtils.join(args, ' '));
        ProcessBuilder pb = new ProcessBuilder(args);
        pb.directory(sourceDirectory.toFile());
        Process process = pb.start();
        int exitCode = process.waitFor();
        return process;
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

    /**
     * Delete openapi and graphql generated files.
     *
     * @param generatedFileName file name that need to delete.
     */
    public static void deleteGeneratedFiles(String generatedFileName, String command) throws IOException {
        Path resourcesPath = RESOURCES_PATH.resolve(command);
        if (Files.exists(resourcesPath)) {
            List<File> listFiles = Arrays.asList(
                    Objects.requireNonNull(new File(String.valueOf(resourcesPath)).listFiles()));
            for (File existsFile: listFiles) {
                String fileName = existsFile.getName();
                if (fileName.equals(generatedFileName) || fileName.equals(generatedFileName + "_service.bal") ||
                        fileName.equals("client.bal") || fileName.equals("types.bal") || fileName.equals("utils.bal") ||
                        fileName.equals("config_types.bal")) {
                    existsFile.delete();
                }
            }
            Path directoryPath = resourcesPath.resolve("tests");
            if (Files.isDirectory(directoryPath)) {
                File file = new File(directoryPath.toString());
                FileUtils.deleteDirectory(file);
            }
        }
    }

    /**
     * Execute the given command.
     *
     * @param command command needs to be execute
     * @return output of the executed command
     */
    public static String executeCommand(String command) throws IOException {
        String output = "";
        File file = new File(getUserHome() + File.separator
                + "temp-" + new Timestamp(System.currentTimeMillis()).getTime() + ".sh");
        file.createNewFile();
        file.setExecutable(true);
        PrintWriter writer = new PrintWriter(file.getPath(), StandardCharsets.UTF_8);
        writer.println(command);
        writer.close();

        ProcessBuilder pb = new ProcessBuilder(file.getPath());
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
        file.delete();
        return output;
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
     * Execute smoke testing to verify installation.
     *
     * @param path Path to the bal file
     * @param jBallerinaVersion Installed jBallerina version
     * @param specVersion Installed language specification
     * @param toolVersion Installed tool version
     * @param versionDisplayText Installed version display text
     */
    public static void testInstallation(String path, String jBallerinaVersion, String specVersion, String toolVersion,
                                        String versionDisplayText) throws IOException {
        Assert.assertEquals(TestUtils.executeCommand(path + " -v"),
                TestUtils.getVersionOutput(jBallerinaVersion, specVersion, toolVersion, versionDisplayText));
    }

    /**
     * Get version output for version command.
     *  @param jBallerinaVersion Installed jBallerina version
     *  @param specVersion Installed language specification
     *  @param toolVersion Installed tool version
     *  @param versionDisplayText display text for installed jBallerina version
     *
     * @return version output
     */
    public static String getVersionOutput(String jBallerinaVersion, String specVersion, String toolVersion,
                                          String versionDisplayText) {
        String toolText = TestUtils.isOldToolVersion(toolVersion) ? "Ballerina tool" : "Update Tool";
        if (jBallerinaVersion.contains(TestUtils.SWAN_LAKE_KEYWORD)) {
            return "Ballerina " + versionDisplayText + " (Swan Lake)\n" + "Language specification " + specVersion +
                    "\n" + toolText + " " + toolVersion + "\n";
        }

        String ballerinaReference = isSupportedRelease(jBallerinaVersion) ? "jBallerina" : "Ballerina";
        return ballerinaReference + " " + jBallerinaVersion + "\n" + "Language specification " + specVersion + "\n" +
                toolText + " " + toolVersion + "\n";
    }

    /**
     * To check whether older tool version before swan lake support
     *
     * @param toolVersion
     * @return returns is a older version
     */
    public static boolean isOldToolVersion(String toolVersion) {
        return toolVersion.equals("0.8.5") || toolVersion.equals("0.8.0");
    }

    /**
     * To check whether installation is a 1.0.x release.
     *
     * @return returns is a 1.0.x release
     */
    public static boolean isSupportedRelease(String version) {
        if (version.contains(SWAN_LAKE_KEYWORD)) {
            return true;
        }

        String[] versions = version.split("\\.");
        return !(versions[0].equals("1") && versions[1].equals("0"));
    }

    /**
     * Get the content of the file.
     * @param filePath Path to the file
     * @return content of the file
     * @throws IOException
     */
    public static String getContent(Path filePath) throws IOException {
        return Files.readString(filePath);
    }

    public static String getStringFromGivenBalFile(Path expectedServiceFile) throws IOException {
        Stream<String> expectedServiceLines = Files.lines(expectedServiceFile);
        String expectedServiceContent = expectedServiceLines.collect(Collectors.joining(System.lineSeparator()));
        expectedServiceLines.close();
        return expectedServiceContent.trim().replaceAll(
                WHITESPACE_PATTERN, "").replaceAll(System.lineSeparator(), "");
    }
}
