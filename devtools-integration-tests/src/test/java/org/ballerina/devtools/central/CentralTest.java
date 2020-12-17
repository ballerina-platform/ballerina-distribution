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

package org.ballerina.devtools.central;

import org.ballerina.devtools.utils.TestUtils;
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

import static org.ballerina.devtools.central.CentralTestUtils.BALLERINA_DEV_CENTRAL;
import static org.ballerina.devtools.central.CentralTestUtils.BALLERINA_TOML;
import static org.ballerina.devtools.central.CentralTestUtils.BALLERINA_HOME_DIR;
import static org.ballerina.devtools.central.CentralTestUtils.MAIN_BAL;
import static org.ballerina.devtools.central.CentralTestUtils.createSettingToml;
import static org.ballerina.devtools.central.CentralTestUtils.deleteFiles;
import static org.ballerina.devtools.central.CentralTestUtils.getEnvVariables;
import static org.ballerina.devtools.central.CentralTestUtils.getExecutableJarPath;
import static org.ballerina.devtools.central.CentralTestUtils.getGenerateExecutableLog;
import static org.ballerina.devtools.central.CentralTestUtils.getPushedToCentralLog;
import static org.ballerina.devtools.central.CentralTestUtils.getString;
import static org.ballerina.devtools.central.CentralTestUtils.randomPackageName;
import static org.ballerina.devtools.central.CentralTestUtils.updateFileToken;
import static org.ballerina.devtools.utils.TestUtils.DISTRIBUTIONS_DIR;
import static org.ballerina.devtools.utils.TestUtils.MAVEN_VERSION;
import static org.ballerina.devtools.utils.TestUtils.executeBuildCommand;
import static org.ballerina.devtools.utils.TestUtils.executeCommand;
import static org.ballerina.devtools.utils.TestUtils.executePushCommand;
import static org.ballerina.devtools.utils.TestUtils.executeSearchCommand;

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
    private String packageSnapshotName;
    private String orgName = "bc2testorg";
    private Map<String, String> envVariables;

    private static final String DISTRIBUTION_FILE_NAME = "ballerina-" + MAVEN_VERSION;
    private static final String DEFAULT_PKG_NAME = "my_package";
    private static final String PROJECT_A = "projectA";
    private static final String PROJECT_B = "projectB";
    private static final String PROJECT_C = "projectC";
    private static final String PROJECT_D = "projectD";
    private static final String PROJECT_SNAPSHOT = "projectSnapshot";
    private static final String TEST_PREFIX = "test_";
    private static final String OUTPUT_CONTAIN_ERRORS = "build output contain errors:";
    private static final String OUTPUT_NOT_CONTAINS_EXP_MSG = "build output does not contain expected message:";

    @BeforeClass()
    public void setUp() throws IOException, InterruptedException {
        setupDistributions();

        tempHomeDirectory = Files.createTempDirectory("bal-test-integration-packaging-home-");
        tempWorkspaceDirectory = Files.createTempDirectory("bal-test-integration-packaging-workspace-");
        createSettingToml(tempHomeDirectory);
        envVariables = addEnvVariables(getEnvVariables());

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
            this.packageSnapshotName = TEST_PREFIX + randomString + "_" + PROJECT_SNAPSHOT;
        } while (isPkgAvailableInCentral(this.packageAName)
                || isPkgAvailableInCentral(this.packageBName)
                || isPkgAvailableInCentral(this.packageCName)
                || isPkgAvailableInCentral(this.packageDName)
                || isPkgAvailableInCentral(this.packageSnapshotName));

        isPkgAvailableInCentral(this.packageAName);

        // Update Ballerina.toml files with new package names"my_package"
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_A).resolve(BALLERINA_TOML), DEFAULT_PKG_NAME,
                        this.packageAName);
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_B).resolve(BALLERINA_TOML), DEFAULT_PKG_NAME,
                        this.packageBName);
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_C).resolve(BALLERINA_TOML), DEFAULT_PKG_NAME,
                        this.packageCName);
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_D).resolve(BALLERINA_TOML), DEFAULT_PKG_NAME,
                        this.packageDName);
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_SNAPSHOT).resolve(BALLERINA_TOML), DEFAULT_PKG_NAME,
                        this.packageSnapshotName);
        // Update imports
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_C).resolve(MAIN_BAL), "<PKG_A>",
                        this.packageAName);
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_C).resolve(MAIN_BAL), "<PKG_B>",
                        this.packageBName);
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_D).resolve(MAIN_BAL), "<PKG_C>",
                        this.packageCName);
    }

    @Test(description = "Build package A with a native lib dependency")
    public void testBuildPackageA() throws IOException, InterruptedException {
        Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_A),
                                            new LinkedList<>(), this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(getGenerateExecutableLog(this.packageAName))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getGenerateExecutableLog(this.packageAName));
        }

        Assert.assertTrue(
                getExecutableJarPath(this.tempWorkspaceDirectory.resolve(PROJECT_A), this.packageAName).toFile()
                        .exists());
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

    @Test(description = "Build package B")
    public void testBuildPackageB() throws IOException, InterruptedException {
        Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_B),
                                       new LinkedList<>(), this.envVariables);

        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(getGenerateExecutableLog(this.packageBName))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getGenerateExecutableLog(this.packageBName));
        }

        Assert.assertTrue(
                getExecutableJarPath(this.tempWorkspaceDirectory.resolve(PROJECT_B), this.packageBName).toFile()
                        .exists());
    }

    @Test(description = "Build package C which depends on Package A and B",
            dependsOnMethods = { "testPushPackageA", "testBuildPackageB" })
    public void testBuildPackageC() throws IOException, InterruptedException {
        String expectedMsg = "cannot resolve module '" + orgName + "/" + this.packageBName + " as pkgB'";
        String unexpectedMsg = "cannot resolve module '" + orgName + "/" + this.packageAName + " as pkgA'";

        Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_C),
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
        Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_C),
                                       new LinkedList<>(), this.envVariables);

        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(getGenerateExecutableLog(this.packageCName))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getGenerateExecutableLog(this.packageCName));
        }

        Assert.assertTrue(
                getExecutableJarPath(this.tempWorkspaceDirectory.resolve(PROJECT_C), this.packageCName).toFile()
                        .exists());
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

    @Test(description = "Build and run package D which depends on Package C", dependsOnMethods = "testPushPackageC")
    public void testBuildAndRunPackageD() throws IOException, InterruptedException {
        Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_D),
                                       new LinkedList<>(), this.envVariables);

        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(getGenerateExecutableLog(this.packageDName))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getGenerateExecutableLog(this.packageDName));
        }

        Assert.assertTrue(
                getExecutableJarPath(this.tempWorkspaceDirectory.resolve(PROJECT_D), this.packageDName).toFile()
                        .exists());

        String runExpectedMsg = "Hello World:110";
        Process run = executeCommand("run", DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_D),
                                     new LinkedList<>(Collections.singletonList(".")), this.envVariables);
        String runOutput = getString(run.getInputStream());
        if (!runOutput.contains(runExpectedMsg)) {
            Assert.fail("run output does not contain expected message:" + runExpectedMsg);
        }
    }

    @Test(description = "Build package with pre-release version")
    public void testBuildSnapshotPackage() throws IOException, InterruptedException {
        Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME,
                                            this.tempWorkspaceDirectory.resolve(PROJECT_SNAPSHOT),
                                            new LinkedList<>(),
                                            this.envVariables);

        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(getGenerateExecutableLog(this.packageSnapshotName))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getGenerateExecutableLog(this.packageSnapshotName));
        }

        Assert.assertTrue(
                getExecutableJarPath(this.tempWorkspaceDirectory.resolve(PROJECT_SNAPSHOT), this.packageSnapshotName)
                        .toFile().exists());
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
        if (!buildOutput.contains(getPushedToCentralLog(orgName, this.packageSnapshotName))) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getPushedToCentralLog(orgName, this.packageSnapshotName));
        }
    }

    @AfterClass
    private void cleanup() throws IOException {
        deleteFiles(tempHomeDirectory);
        deleteFiles(tempWorkspaceDirectory);
    }

    /**
     * Get environment variables and add ballerina_home as a env variable the tmp directory.
     *
     * @return env directory variable array
     */
    private Map<String, String> addEnvVariables(Map<String, String> envVariables) {
        envVariables.put(BALLERINA_HOME_DIR, tempHomeDirectory.toString());
        envVariables.put(BALLERINA_DEV_CENTRAL, "true");
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

    /**
     * Copy test resources to temp directory.
     */
    static class Copy extends SimpleFileVisitor<Path> {
        private Path fromPath;
        private Path toPath;
        private StandardCopyOption copyOption;

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
