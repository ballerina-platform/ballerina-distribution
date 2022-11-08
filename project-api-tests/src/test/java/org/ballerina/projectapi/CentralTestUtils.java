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

import okhttp3.Call;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import org.testng.Assert;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static java.net.HttpURLConnection.HTTP_NO_CONTENT;
import static org.ballerina.projectapi.TestUtils.DISTRIBUTION_FILE_NAME;
import static org.ballerina.projectapi.TestUtils.OUTPUT_CONTAIN_ERRORS;
import static org.ballerina.projectapi.TestUtils.executePackCommand;
import static org.ballerina.projectapi.TestUtils.executePushCommand;
import static org.ballerina.projectapi.TestUtils.executeSearchCommand;

/**
 * Utility class for central tests.
 */
public class CentralTestUtils {

    private CentralTestUtils() {
    }

    static final String BALLERINA_HOME_DIR = "BALLERINA_HOME_DIR";
    static final String BALLERINA_DEV_CENTRAL = "BALLERINA_DEV_CENTRAL";
    static final String BALLERINA_CENTRAL_ACCESS_TOKEN = "BALLERINA_CENTRAL_ACCESS_TOKEN";
    static final String BALLERINA_TOML = "Ballerina.toml";
    static final String DEPENDENCIES_TOML = "Dependencies.toml";
    static final String MAIN_BAL = "main.bal";
    static final String COMMON_VERSION = "1.0.0";
    static final String TEST_PREFIX = "test_";
    static final String ANY_PLATFORM = "any";
    static final String JAVA11_PLATFORM = "java11";
    static final String BALLERINA_ARTIFACT_TYPE = "bala";
    static final String OUTPUT_NOT_CONTAINS_EXP_MSG = "build output does not contain expected message:";

    /**
     * Generate random package name.
     *
     * @param count number of characters required
     * @return generated name
     */
    static String randomPackageName(int count) {
        String upperCaseAlpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String lowerCaseAlpha = "abcdefghijklmnopqrstuvwxyz";
        String alpha = upperCaseAlpha + lowerCaseAlpha;
        StringBuilder builder = new StringBuilder();
        while (count-- != 0) {
            int character = (int) (Math.random() * alpha.length());
            builder.append(alpha.charAt(character));
        }
        return builder.toString();
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
     * Get token of ballerina-bot required to dispatch GitHub workflows.
     *
     * @return token required to dispatch GitHub workflows.
     */
    public static String getBallerinaBotToken() {
        return System.getenv("ballerinaBotToken");
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
     * Update the file token by changing the guess token.
     *
     * @param filePath    The file path.
     * @param guessToken  The guess token.
     * @param actualToken The guess token.
     * @throws IOException Error when writing to Ballerina.toml
     */
    static void updateFileToken(Path filePath, String guessToken, String actualToken) throws IOException {
        Stream<String> lines = Files.lines(filePath);
        List<String> replaced = lines.map(line -> line.replaceAll(guessToken, actualToken))
                .collect(Collectors.toList());
        Files.write(filePath, replaced);
        lines.close();
    }

    /**
     * Convert input stream to string.
     *
     * @param outputs input stream
     * @return converted string
     * @throws IOException Error when reading from input stream
     */
    static String getString(InputStream outputs) throws IOException {
        try (BufferedReader br = new BufferedReader(new InputStreamReader(outputs))) {
            Stream<String> logLines = br.lines();
            String generatedLog = logLines.collect(Collectors.joining("\n"));
            logLines.close();
            return generatedLog;
        }
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
     * Get the log output when package is successfully pushed to Central.
     *
     * @param orgName Organization name
     * @param pkgName Name of the package pushed to central
     * @param version Package Version
     * @return Expected log message
     */
    static String getPushedToCentralLog(String orgName, String pkgName, String version) {
        return orgName + "/" + pkgName + ":" + version + " pushed to central successfully";
    }

    /**
     * Get pushed to central log.
     *
     * @param orgName Organization name
     * @param pkgName package name
     * @return pushed to central log
     */
    static String getPushedToCentralLog(String orgName, String pkgName) {
        return orgName + "/" + pkgName + ":1.0.0 pushed to central successfully";
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
        return projectPath.resolve("target").resolve(BALLERINA_ARTIFACT_TYPE)
                .resolve(org + "-" + pkgName + "-" + platform + "-" + version + ".bala");
    }

    /**
     * Check if package already available on central.
     *
     * @param pkg package
     * @param tempWorkspaceDirectory Path to workspace
     * @param envVariables Environmental variables
     * @return whether the package is available on central
     * @throws IOException
     * @throws InterruptedException
     */
    static boolean isPkgAvailableInCentral(String pkg, Path tempWorkspaceDirectory,
                                           Map<String, String> envVariables) throws IOException, InterruptedException {
        String buildOutput = searchPackageDetails(pkg, tempWorkspaceDirectory, envVariables);
        return !buildOutput.contains("no modules found");
    }

    /**
     * Returns true if the provided version is available on central.
     *
     * @param pkg package
     * @param tempWorkspaceDirectory Path to workspace
     * @param envVariables Environmental variables
     * @param version version to check availability
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    static boolean isPkgVersionAvailableInCentral(String pkg, Path tempWorkspaceDirectory,
                                                  Map<String, String> envVariables, String version)
            throws IOException, InterruptedException {
        String buildOutput = searchPackageDetails(pkg, tempWorkspaceDirectory, envVariables);
        return (!buildOutput.contains("no modules found") && buildOutput.contains(version));
    }

    /**
     * Search for the given package on Central.
     *
     * @param pkg package
     * @param tempWorkspaceDirectory Path to workspace
     * @param envVariables Environmental variables
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    private static String searchPackageDetails(String pkg, Path tempWorkspaceDirectory,
                                           Map<String, String> envVariables) throws IOException, InterruptedException {
        Process search = executeSearchCommand(DISTRIBUTION_FILE_NAME,
                tempWorkspaceDirectory,
                new LinkedList<>(Collections.singletonList(pkg)),
                envVariables);
        String buildErrors = getString(search.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }
        return getString(search.getInputStream());
    }

    /**
     * Build bala for a package.
     *
     * @param tempWorkspaceDirectory Path to workspace
     * @param envVariables Environmental variables
     * @param packageName Package
     * @param orgName Organization name
     * @param version Package Version
     * @param additionalArgs Additional arguments to pass wben building package.
     * @throws IOException
     * @throws InterruptedException
     */
    static void buildPackageBala(Path tempWorkspaceDirectory, Map<String, String> envVariables, String packageName,
                             String orgName, String version, List<String> additionalArgs)
            throws IOException, InterruptedException {
        List<String> argsCollection = new ArrayList(additionalArgs);
        Process build = executePackCommand(DISTRIBUTION_FILE_NAME,
                tempWorkspaceDirectory.resolve(packageName),
                new LinkedList<>(argsCollection), envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }
        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(getGenerateBalaLog(orgName,
                packageName, ANY_PLATFORM, version))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getGenerateBalaLog(orgName,
                    packageName, ANY_PLATFORM, version));
        }
        Assert.assertTrue(
                getBalaPath(tempWorkspaceDirectory.resolve(packageName), orgName, packageName, ANY_PLATFORM,
                        version).toFile().exists());
    }

    /**
     * Push a bala to remote repository.
     *
     * @param tempWorkspaceDirectory Path to workspace
     * @param projectName Project name
     * @param envVariables Environmental variables
     * @param orgName Organization name
     * @param packageName package
     * @param version Package Version
     * @throws IOException
     * @throws InterruptedException
     */
    static void testPushPackage(Path tempWorkspaceDirectory, String projectName, Map<String, String> envVariables,
                                String orgName, String packageName, String version)
            throws IOException, InterruptedException {
        Process build = executePushCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory.resolve(projectName),
                new LinkedList<>(), envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }
        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(getPushedToCentralLog(orgName, packageName, version))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getPushedToCentralLog(orgName, packageName));
        }
    }

    /**
     * Push a bala to `local` repository.
     *
     * @param tempWorkspaceDirectory Path to workspace
     * @param projectName Project name
     * @param envVariables Environmental variables
     * @param orgName Organization name
     * @param packageName package
     * @param version Package Version
     * @throws IOException
     * @throws InterruptedException
     */
    static void testPushPackageToLocal(Path tempWorkspaceDirectory, String projectName,
                                       Map<String, String> envVariables, String orgName,
                                       String packageName, String version)
            throws IOException, InterruptedException {
        Process build = executePushCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory.resolve(projectName),
                new LinkedList<>(Collections.singletonList("--repository=local")), envVariables);
        // The success message is pushed to error stream for this local push.
        String buildOutput = getString(build.getInputStream());
        String expectedLog = "Successfully pushed target/bala/" + orgName + "-" + packageName + "-any-" + version +
                ".bala to 'local' repository.";
        if (!buildOutput.contains(expectedLog)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedLog);
        }
    }

    /**
     * Push a bala to central using bala path.
     *
     * @param tempWorkspaceDirectory Path to workspace
     * @param projectName Project name
     * @param envVariables Environmental variables
     * @param orgName Organization name
     * @param packageName package
     * @param version Package Version
     * @param balaPath Path to the bala file to be pushed
     * @throws IOException
     * @throws InterruptedException
     */
    public static void testPushPackageUsingBalaPath(Path tempWorkspaceDirectory, String projectName,
                                       Map<String, String> envVariables, String orgName,
                                       String packageName, String version, String balaPath)
            throws IOException, InterruptedException {
        Process build = executePushCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory.resolve(projectName),
                new LinkedList<>(Collections.singletonList(balaPath)), envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }
        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(getPushedToCentralLog(orgName, packageName, version))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getPushedToCentralLog(orgName, packageName));
        }
    }


    /**
     * Delete the packages pushed during project API tests.
     *
     * @param caller the test class calling this method
     * @throws IOException if request could not be handled
     */
    public static void deleteTestPackagesFromCentral(String caller) throws IOException {
        String ghOrg = "wso2-enterprise";
        String ghRepo = "ballerina-registry";
        String workflowId = "30610274";
        String branch = "main";
        boolean isWorkflowDispatched = dispatchGitWorkflow(ghOrg, ghRepo, workflowId, branch);
        if (!isWorkflowDispatched) {
            Assert.fail("Failed deleting test packages from central after " + caller + " tests");
        }
    }

    /**
     * Dispatch a given GitHub workflow.
     *
     * @param ghOrg GitHub organization
     * @param ghRepo GitHub repository
     * @param workflowId GitHub workflow ID
     * @param branch branch name which the workflow runs against
     * @return true if workflow API call is successful, else false
     * @throws IOException if request could not be handled
     */
    public static boolean dispatchGitWorkflow(String ghOrg, String ghRepo, String workflowId, String branch)
            throws IOException {
        String url = "https://api.github.com/repos/" + ghOrg + "/" + ghRepo
                + "/actions/workflows/" + workflowId + "/dispatches";
        OkHttpClient client = new OkHttpClient();
        String data = "{\"ref\": \"" + branch + "\"}";
        MediaType jsonType = MediaType.parse("application/json; charset=utf-8");
        RequestBody requestBody = RequestBody.create(jsonType, data);
        Request resolutionReq = new Request.Builder()
                .post(requestBody)
                .url(url)
                .addHeader("Authorization", "Bearer " + getBallerinaBotToken())
                .build();
        Call resolutionReqCall = client.newCall(resolutionReq);
        try (Response response = resolutionReqCall.execute()) {
            return response.code() == HTTP_NO_CONTENT;
        }
    }
}
