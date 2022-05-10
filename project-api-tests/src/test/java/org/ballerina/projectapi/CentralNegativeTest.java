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

package org.ballerina.projectapi;

import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collections;
import java.util.LinkedList;
import java.util.Map;
import java.util.Objects;

import static org.ballerina.projectapi.CentralTestUtils.BALLERINA_CENTRAL_ACCESS_TOKEN;
import static org.ballerina.projectapi.CentralTestUtils.BALLERINA_DEV_CENTRAL;
import static org.ballerina.projectapi.CentralTestUtils.BALLERINA_HOME_DIR;
import static org.ballerina.projectapi.CentralTestUtils.BALLERINA_TOML;
import static org.ballerina.projectapi.CentralTestUtils.deleteFiles;
import static org.ballerina.projectapi.CentralTestUtils.getBalaPath;
import static org.ballerina.projectapi.CentralTestUtils.getEnvVariables;
import static org.ballerina.projectapi.CentralTestUtils.getGenerateBalaLog;
import static org.ballerina.projectapi.CentralTestUtils.getString;
import static org.ballerina.projectapi.CentralTestUtils.randomPackageName;
import static org.ballerina.projectapi.CentralTestUtils.updateFileToken;
import static org.ballerina.projectapi.TestUtils.CODE_NAME;
import static org.ballerina.projectapi.TestUtils.DISTRIBUTIONS_DIR;
import static org.ballerina.projectapi.TestUtils.MAVEN_VERSION;
import static org.ballerina.projectapi.TestUtils.OUTPUT_CONTAIN_ERRORS;
import static org.ballerina.projectapi.TestUtils.executePackCommand;
import static org.ballerina.projectapi.TestUtils.executePushCommand;
import static org.ballerina.projectapi.TestUtils.executeSearchCommand;

/**
 * Negative tests related central packaging.
 */
public class CentralNegativeTest {

    private Path tempHomeDirectory;
    private Path tempWorkspaceDirectory;
    private String packageAName;
    private Map<String, String> envVariables;

    private static final String ORG_NAME = "bctestorg";
    private static final String DISTRIBUTION_FILE_NAME = "ballerina-" + MAVEN_VERSION + "-" + CODE_NAME;
    private static final String DEFAULT_PKG_NAME = "my_package";
    private static final String PROJECT_A = "projectA";
    private static final String COMMON_VERSION = "1.0.0";
    private static final String TEST_PREFIX = "test_";
    private static final String ANY_PLATFORM = "any";
    private static final String OUTPUT_NOT_CONTAINS_EXP_MSG = "build output does not contain expected message:";

    @BeforeClass()
    public void setUp() throws IOException, InterruptedException {
        setupDistributions();

        tempHomeDirectory = Files.createTempDirectory("bal-test-integration-packaging-home-");
        tempWorkspaceDirectory = Files.createTempDirectory("bal-test-integration-packaging-workspace-");
        envVariables = getEnvVariables();

        // Copy test resources to temp workspace directory
        try {
            URI testResourcesURI = Objects.requireNonNull(getClass().getClassLoader().getResource("central")).toURI();
            Files.walkFileTree(Paths.get(testResourcesURI),
                               new CentralTest.Copy(Paths.get(testResourcesURI), this.tempWorkspaceDirectory));
        } catch (URISyntaxException e) {
            Assert.fail("error loading resources");
        }

        // Get random package names
        do {
            String randomString = randomPackageName(10);
            this.packageAName = TEST_PREFIX + randomString + "_" + PROJECT_A;
        } while (isPkgAvailableInCentral(this.packageAName));

        isPkgAvailableInCentral(this.packageAName);

        // Update Ballerina.toml files with new package name "my_package"
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_A).resolve(BALLERINA_TOML), DEFAULT_PKG_NAME,
                        this.packageAName);
    }

    @Test(description = "Build and push package with invalid access token", enabled = false)
    public void testPushPackageWithInvalidAccessToken() throws IOException, InterruptedException {
        Map<String, String> envVariablesWithInvalidAccessToken = addEnvVariablesWithInvalidAccessToken(
                this.envVariables);
        Process build = executePackCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_A),
                                            new LinkedList<>(), envVariablesWithInvalidAccessToken);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(getGenerateBalaLog(ORG_NAME, this.packageAName, ANY_PLATFORM, COMMON_VERSION))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getGenerateBalaLog(ORG_NAME, this.packageAName, ANY_PLATFORM,
                                                                         COMMON_VERSION));
        }

        Assert.assertTrue(
                getBalaPath(this.tempWorkspaceDirectory.resolve(PROJECT_A), ORG_NAME, this.packageAName, ANY_PLATFORM,
                            COMMON_VERSION).toFile().exists());

        Process push = executePushCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_A),
                                          new LinkedList<>(), envVariablesWithInvalidAccessToken);
        String pushErrors = getString(push.getErrorStream());
        if (pushErrors.isEmpty()) {
            Assert.fail("push command output does not contain any error");
        }

        String expectedError = "ballerina: unauthorized access token for organization: 'bctestorg'. "
                + "reason: unauthorized to perform this operation as access token is invalid. "
                + "check access token set in 'Settings.toml' file.";
        Assert.assertEquals(pushErrors, expectedError);
    }

    @AfterClass
    private void cleanup() throws IOException {
        deleteFiles(tempHomeDirectory);
        deleteFiles(tempWorkspaceDirectory);
    }

    private Map<String, String> addEnvVariablesWithInvalidAccessToken(Map<String, String> envVariables) {
        envVariables.put(BALLERINA_HOME_DIR, tempHomeDirectory.toString());
        envVariables.put(BALLERINA_DEV_CENTRAL, "true");
        envVariables.put(BALLERINA_CENTRAL_ACCESS_TOKEN, "cedbeff5-some-invalid-token-f38d4abf");
        return envVariables;
    }

    /**
     * Clean and set up distributions.
     */
    private void setupDistributions() throws IOException {
        TestUtils.cleanDistribution();
        TestUtils.prepareDistribution(DISTRIBUTIONS_DIR.resolve(DISTRIBUTION_FILE_NAME + ".zip"));
    }

    /**
     * Check package already available in central.
     *
     * @param pkg package
     * @return is package available in central
     */
    private boolean isPkgAvailableInCentral(String pkg) throws IOException, InterruptedException {
        Process search = executeSearchCommand(DISTRIBUTION_FILE_NAME,
                                              this.tempWorkspaceDirectory,
                                              new LinkedList<>(Collections.singletonList(pkg)),
                                              this.envVariables);
        String buildErrors = getString(search.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }

        String buildOutput = getString(search.getInputStream());
        return !buildOutput.contains("no modules found");
    }
}
