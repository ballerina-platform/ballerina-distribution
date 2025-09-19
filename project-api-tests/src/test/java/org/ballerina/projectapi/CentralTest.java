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

import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.StandardCopyOption;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.Collections;
import java.util.LinkedList;
import java.util.Map;
import java.util.Objects;

import static org.ballerina.projectapi.CentralTestUtils.ANY_PLATFORM;
import static org.ballerina.projectapi.CentralTestUtils.BALLERINA_TOML;
import static org.ballerina.projectapi.CentralTestUtils.COMMON_VERSION;
import static org.ballerina.projectapi.CentralTestUtils.JAVA_PLATFORM;
import static org.ballerina.projectapi.CentralTestUtils.MAIN_BAL;
import static org.ballerina.projectapi.CentralTestUtils.OUTPUT_NOT_CONTAINS_EXP_MSG;
import static org.ballerina.projectapi.CentralTestUtils.PULLED_FROM_CENTRAL_MSG;
import static org.ballerina.projectapi.CentralTestUtils.TEST_PREFIX;
import static org.ballerina.projectapi.CentralTestUtils.createSettingToml;
import static org.ballerina.projectapi.CentralTestUtils.deleteBalaOfPackage;
import static org.ballerina.projectapi.CentralTestUtils.deleteFiles;
import static org.ballerina.projectapi.CentralTestUtils.getBalaPath;
import static org.ballerina.projectapi.CentralTestUtils.getEnvVariables;
import static org.ballerina.projectapi.CentralTestUtils.getGenerateBalaLog;
import static org.ballerina.projectapi.CentralTestUtils.getPushedToCentralLog;
import static org.ballerina.projectapi.CentralTestUtils.getString;
import static org.ballerina.projectapi.CentralTestUtils.isPkgAvailableInCentral;
import static org.ballerina.projectapi.CentralTestUtils.randomPackageName;
import static org.ballerina.projectapi.CentralTestUtils.updateFileToken;
import static org.ballerina.projectapi.TestUtils.DISTRIBUTION_FILE_NAME;
import static org.ballerina.projectapi.TestUtils.OUTPUT_CONTAIN_ERRORS;
import static org.ballerina.projectapi.TestUtils.executePackCommand;
import static org.ballerina.projectapi.TestUtils.executePullCommand;
import static org.ballerina.projectapi.TestUtils.executePushCommand;

/**
 * Tests related central packaging.
 */
public class CentralTest {

    private Path tempHomeDirectory;
    private Path tempWorkspaceDirectory;
    private String packageAName;
    private String packageBName;
    private String packageCName;
    private String packageDName;
    private String packageEName;
    private String packageFName;
    private String packageGName;
    private String packageSnapshotName;
    private final String orgName = "bctestorg";
    private Map<String, String> envVariables;

    private static final String DEFAULT_PKG_NAME = "my_package";
    private static final String PROJECT_A = "projectA";
    private static final String PROJECT_B = "projectB";
    private static final String PROJECT_C = "projectC";
    private static final String PROJECT_D = "projectD";
    private static final String PROJECT_E = "projectE";
    private static final String PROJECT_F = "projectF";
    private static final String PROJECT_G = "projectG";
    private static final String PROJECT_SNAPSHOT = "projectSnapshot";

    @BeforeClass()
    public void setUp() throws IOException, InterruptedException {
        TestUtils.setupDistributions();
        tempHomeDirectory = Files.createTempDirectory("bal-test-integration-packaging-home-");
        tempWorkspaceDirectory = Files.createTempDirectory("bal-test-integration-packaging-workspace-");
        createSettingToml(tempHomeDirectory);
        envVariables = TestUtils.addEnvVariables(getEnvVariables(), tempHomeDirectory);

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
            this.packageBName = TEST_PREFIX + randomString + "_" + PROJECT_B;
            this.packageCName = TEST_PREFIX + randomString + "_" + PROJECT_C;
            this.packageDName = TEST_PREFIX + randomString + "_" + PROJECT_D;
            this.packageEName = TEST_PREFIX + randomString + "_" + PROJECT_E;
            this.packageFName = TEST_PREFIX + randomString + "_" + PROJECT_F;
            this.packageGName = TEST_PREFIX + randomString + "_" + PROJECT_G;
            this.packageSnapshotName = TEST_PREFIX + randomString + "_" + PROJECT_SNAPSHOT;
        } while (isPkgAvailableInCentral(this.packageAName, tempWorkspaceDirectory, envVariables)
                || isPkgAvailableInCentral(this.packageBName, tempWorkspaceDirectory, envVariables)
                || isPkgAvailableInCentral(this.packageCName, tempWorkspaceDirectory, envVariables)
                || isPkgAvailableInCentral(this.packageDName, tempWorkspaceDirectory, envVariables)
                || isPkgAvailableInCentral(this.packageEName, tempWorkspaceDirectory, envVariables)
                || isPkgAvailableInCentral(this.packageFName, tempWorkspaceDirectory, envVariables)
                || isPkgAvailableInCentral(this.packageGName, tempWorkspaceDirectory, envVariables)
                || isPkgAvailableInCentral(this.packageSnapshotName, tempWorkspaceDirectory, envVariables));

        isPkgAvailableInCentral(this.packageAName, tempWorkspaceDirectory, envVariables);

        // Update Ballerina.toml files with new package names"my_package"
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_A).resolve(BALLERINA_TOML), DEFAULT_PKG_NAME,
                        this.packageAName);
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_B).resolve(BALLERINA_TOML), DEFAULT_PKG_NAME,
                        this.packageBName);
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_C).resolve(BALLERINA_TOML), DEFAULT_PKG_NAME,
                        this.packageCName);
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_D).resolve(BALLERINA_TOML), DEFAULT_PKG_NAME,
                        this.packageDName);
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_E).resolve(BALLERINA_TOML), DEFAULT_PKG_NAME,
                this.packageEName);
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_F).resolve(BALLERINA_TOML), DEFAULT_PKG_NAME,
                this.packageFName);
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_G).resolve(BALLERINA_TOML), DEFAULT_PKG_NAME,
                this.packageGName);
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_SNAPSHOT).resolve(BALLERINA_TOML), DEFAULT_PKG_NAME,
                        this.packageSnapshotName);
        // Update imports
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_C).resolve(MAIN_BAL), "<PKG_A>",
                        this.packageAName);
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_C).resolve(MAIN_BAL), "<PKG_B>",
                        this.packageBName);
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_D).resolve(MAIN_BAL), "<PKG_C>",
                        this.packageCName);
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_F).resolve(MAIN_BAL), "<PKG_E>",
                this.packageEName);
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_G).resolve(MAIN_BAL), "<PKG_F>",
                this.packageFName);
    }

    @Test(description = "Build package A with a native lib dependency")
    public void testBuildPackageA() throws IOException, InterruptedException {
        Process build = executePackCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_A),
                                            new LinkedList<>(), this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(getGenerateBalaLog(orgName, this.packageAName, ANY_PLATFORM, COMMON_VERSION))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getGenerateBalaLog(orgName, this.packageAName, ANY_PLATFORM,
                                                                         COMMON_VERSION));
        }

        Assert.assertTrue(
                getBalaPath(this.tempWorkspaceDirectory.resolve(PROJECT_A), orgName, this.packageAName, ANY_PLATFORM,
                            COMMON_VERSION).toFile().exists());
    }

    @Test(description = "Push package A to central", dependsOnMethods = "testBuildPackageA")
    public void testPushPackageA() throws IOException, InterruptedException {
        Process build = executePushCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_A),
                                       new LinkedList<>(), this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(getPushedToCentralLog(orgName, packageAName))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getPushedToCentralLog(orgName, packageAName));
        }
    }

    @Test(description = "Build package B which has java21 platform dependency")
    public void testBuildPackageB() throws IOException, InterruptedException {
        Process build = executePackCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_B),
                                       new LinkedList<>(), this.envVariables);

        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(getGenerateBalaLog(orgName, this.packageBName, JAVA_PLATFORM, COMMON_VERSION))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getGenerateBalaLog(orgName, this.packageBName, JAVA_PLATFORM,
                                                                         COMMON_VERSION));
        }
        Assert.assertTrue(
                getBalaPath(this.tempWorkspaceDirectory.resolve(PROJECT_B), orgName, this.packageBName, JAVA_PLATFORM,
                            COMMON_VERSION).toFile().exists());
    }

    @Test(description = "Build package C which depends on Package A and B",
            dependsOnMethods = { "testPushPackageA", "testBuildPackageB" })
    public void testBuildPackageC() throws IOException, InterruptedException {
        String expectedMsg = "cannot resolve module '" + orgName + "/" + this.packageBName + " as pkgB'";
        String unexpectedMsg = "cannot resolve module '" + orgName + "/" + this.packageAName + " as pkgA'";

        Process build = executePackCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_C),
                                       new LinkedList<>(), this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (buildErrors.isEmpty()) {
            Assert.fail("build output should contain errors.");
        }
        if (buildErrors.contains(unexpectedMsg)) {
            Assert.fail("build output should not contain unexpected message:" + unexpectedMsg);
        }
        if (!buildErrors.contains(expectedMsg)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedMsg);
        }
    }

    @Test(description = "Push package B to central", dependsOnMethods = "testBuildPackageC")
    public void testPushPackageB() throws IOException, InterruptedException {
        Process build = executePushCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_B),
                                       new LinkedList<>(), this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(getPushedToCentralLog(orgName, this.packageBName))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getPushedToCentralLog(orgName, this.packageBName));
        }
    }

    @Test(description = "Build package C after pushing Package B", dependsOnMethods = "testPushPackageB")
    public void testBuildPackageCAgain() throws IOException, InterruptedException {
        Process build = executePackCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_C),
                                       new LinkedList<>(), this.envVariables);

        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(getGenerateBalaLog(orgName, this.packageCName, ANY_PLATFORM, COMMON_VERSION))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getGenerateBalaLog(orgName, this.packageCName, ANY_PLATFORM,
                                                                         COMMON_VERSION));
        }

        Assert.assertTrue(
                getBalaPath(this.tempWorkspaceDirectory.resolve(PROJECT_C), orgName, this.packageCName, ANY_PLATFORM,
                            COMMON_VERSION).toFile().exists());
    }

    @Test(description = "Push package C to central", dependsOnMethods = "testBuildPackageCAgain")
    public void testPushPackageC() throws IOException, InterruptedException {
        Process build = executePushCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_C),
                                       new LinkedList<>(), this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(getPushedToCentralLog(orgName, this.packageCName))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getPushedToCentralLog(orgName, this.packageCName));
        }
    }

    @Test(description = "Build package with pre-release version")
    public void testBuildSnapshotPackage() throws IOException, InterruptedException {
        String snapshotVersion = "1.0.0-snapshot";
        Process build = executePackCommand(DISTRIBUTION_FILE_NAME,
                                            this.tempWorkspaceDirectory.resolve(PROJECT_SNAPSHOT),
                                            new LinkedList<>(),
                                            this.envVariables);

        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(getGenerateBalaLog(
                orgName, this.packageSnapshotName, ANY_PLATFORM, snapshotVersion))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG
                                + getGenerateBalaLog(orgName, this.packageSnapshotName, ANY_PLATFORM, snapshotVersion));
        }

        Assert.assertTrue(
                getBalaPath(this.tempWorkspaceDirectory.resolve(PROJECT_SNAPSHOT), orgName, this.packageSnapshotName,
                            ANY_PLATFORM, snapshotVersion).toFile().exists());
    }

    @Test(description = "Push package with pre-release version to central",
            dependsOnMethods = "testBuildSnapshotPackage")
    public void testPushSnapshotPackage() throws IOException, InterruptedException {
        Process build = executePushCommand(DISTRIBUTION_FILE_NAME,
                                           this.tempWorkspaceDirectory.resolve(PROJECT_SNAPSHOT),
                                           new LinkedList<>(),
                                           this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        String expectedMsg =
                orgName + "/" + this.packageSnapshotName + ":1.0.0-snapshot pushed to central successfully";
        if (!buildOutput.contains(expectedMsg)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedMsg);
        }
    }

    @Test(description = "Pull package with pre-release version from central",
            dependsOnMethods = "testPushSnapshotPackage")
    public void testPullSnapshotPackage() throws IOException, InterruptedException {
        String pkg = orgName + "/" + this.packageSnapshotName + ":1.0.0-snapshot";

        Process build = executePullCommand(DISTRIBUTION_FILE_NAME,
                                           this.tempWorkspaceDirectory.resolve(PROJECT_SNAPSHOT),
                                           new LinkedList<>(Collections.singletonList(pkg)),
                                           this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        String expectedMsg = pkg + " pulled from central successfully";
        if (!buildOutput.contains(expectedMsg)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedMsg);
        }
    }

    @Test(description = "Build package E")
    public void testBuildPackageE() throws IOException, InterruptedException {
        Process build = executePackCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_E),
                new LinkedList<>(), this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }
        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(getGenerateBalaLog(orgName, this.packageEName, ANY_PLATFORM, COMMON_VERSION))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getGenerateBalaLog(orgName, this.packageEName, ANY_PLATFORM,
                    COMMON_VERSION));
        }
        Assert.assertTrue(
                getBalaPath(this.tempWorkspaceDirectory.resolve(PROJECT_E), orgName, this.packageEName, ANY_PLATFORM,
                        COMMON_VERSION).toFile().exists());
    }

    @Test(description = "Push package E to the central", dependsOnMethods = "testBuildPackageE")
    public void testPushPackageE() throws IOException, InterruptedException {
        Process push = executePushCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_E),
                new LinkedList<>(), this.envVariables);
        String pushErrors = getString(push.getErrorStream());
        if (!pushErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + pushErrors);
        }
        String pushOutput = getString(push.getInputStream());
        if (!pushOutput.contains(getPushedToCentralLog(orgName, this.packageEName))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getPushedToCentralLog(orgName, this.packageEName));
        }
    }

    @Test(description = "Build package F", dependsOnMethods = "testPushPackageE")
    public void testBuildPackageF() throws IOException, InterruptedException {
        Process build = executePackCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_F),
                new LinkedList<>(), this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }
        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(getGenerateBalaLog(orgName, this.packageFName, ANY_PLATFORM, COMMON_VERSION))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getGenerateBalaLog(orgName, this.packageFName, ANY_PLATFORM,
                    COMMON_VERSION));
        }
        Assert.assertTrue(
                getBalaPath(this.tempWorkspaceDirectory.resolve(PROJECT_F), orgName, this.packageFName, ANY_PLATFORM,
                        COMMON_VERSION).toFile().exists());
    }

    @Test(description = "Push package F to the central", dependsOnMethods = "testBuildPackageF")
    public void testPushPackageF() throws IOException, InterruptedException {
        Process push = executePushCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_F),
                new LinkedList<>(), this.envVariables);
        String pushErrors = getString(push.getErrorStream());
        if (!pushErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + pushErrors);
        }
        String pushOutput = getString(push.getInputStream());
        if (!pushOutput.contains(getPushedToCentralLog(orgName, this.packageFName))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getPushedToCentralLog(orgName, this.packageFName));
        }
    }

    @Test(description = "Build package G", dependsOnMethods = "testPushPackageF")
    public void testBuildPackageG() throws IOException, InterruptedException {
        Process build = executePackCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_G),
                new LinkedList<>(), this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }
        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(getGenerateBalaLog(orgName, this.packageGName, ANY_PLATFORM, COMMON_VERSION))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getGenerateBalaLog(orgName, this.packageGName, ANY_PLATFORM,
                    COMMON_VERSION));
        }
        Assert.assertTrue(
                getBalaPath(this.tempWorkspaceDirectory.resolve(PROJECT_G), orgName, this.packageGName, ANY_PLATFORM,
                        COMMON_VERSION).toFile().exists());
    }

    @Test(description = "Push package G", dependsOnMethods = "testBuildPackageG")
    public void testPushPackageG() throws IOException, InterruptedException {
        Process push = executePushCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_G),
                new LinkedList<>(), this.envVariables);
        String pushErrors = getString(push.getErrorStream());
        if (!pushErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + pushErrors);
        }
        String pushOutput = getString(push.getInputStream());
        if (!pushOutput.contains(getPushedToCentralLog(orgName, this.packageGName))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getPushedToCentralLog(orgName, this.packageGName));
        }
    }

    @Test(description = "Pull package G from central. Should pull both E, F since they are dependencies of G.",
            dependsOnMethods = "testPushPackageG")
    public void testPullPackageG() throws IOException, InterruptedException {
        deleteBalaOfPackage(orgName, packageEName);
        deleteBalaOfPackage(orgName, packageFName);
        deleteBalaOfPackage(orgName, packageGName);

        String pkgE = orgName + "/" + this.packageEName + ":1.0.0";
        String pkgF = orgName + "/" + this.packageFName + ":1.0.0";
        String pkgG = orgName + "/" + this.packageGName + ":1.0.0";
        Process pull = executePullCommand(DISTRIBUTION_FILE_NAME,
                this.tempWorkspaceDirectory.resolve(PROJECT_G),
                new LinkedList<>(Collections.singletonList(pkgG)),
                this.envVariables);
        String buildErrors = getString(pull.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }

        String buildOutput = getString(pull.getInputStream());
        String expectedMsg1 = pkgE + PULLED_FROM_CENTRAL_MSG;
        String expectedMsg2 = pkgF + PULLED_FROM_CENTRAL_MSG;
        String expectedMsg3 = pkgG + PULLED_FROM_CENTRAL_MSG;
        if (!buildOutput.contains(expectedMsg1)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedMsg1);
        }
        if (!buildOutput.contains(expectedMsg2)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedMsg2);
        }
        if (!buildOutput.contains(expectedMsg3)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedMsg3);
        }
    }

    @AfterClass
    private void cleanup() throws IOException {
        deleteFiles(tempHomeDirectory);
        deleteFiles(tempWorkspaceDirectory);
    }

    /**
     * Copy test resources to temp directory.
     */
    static class Copy extends SimpleFileVisitor<Path> {
        private final Path fromPath;
        private final Path toPath;
        private final StandardCopyOption copyOption;

        Copy(Path fromPath, Path toPath, StandardCopyOption copyOption) {
            this.fromPath = fromPath;
            this.toPath = toPath;
            this.copyOption = copyOption;
        }

        Copy(Path fromPath, Path toPath) {
            this(fromPath, toPath, StandardCopyOption.REPLACE_EXISTING);
        }

        @Override
        public FileVisitResult preVisitDirectory(Path dir, BasicFileAttributes attrs) throws IOException {

            Path targetPath = toPath.resolve(fromPath.relativize(dir).toString());
            if (!Files.exists(targetPath)) {
                Files.createDirectory(targetPath);
            }
            return FileVisitResult.CONTINUE;
        }

        @Override
        public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {

            Files.copy(file, toPath.resolve(fromPath.relativize(file).toString()), copyOption);
            return FileVisitResult.CONTINUE;
        }
    }
}
