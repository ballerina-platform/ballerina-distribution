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

import java.io.IOException;
import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.StandardCopyOption;
import java.nio.file.attribute.BasicFileAttributes;

/**
 * Tests related central packaging.
 */
public class CentralTest {
//
//    private Path tempHomeDirectory;
//    private Path tempWorkspaceDirectory;
//    private String packageAName;
//    private String packageBName;
//    private String packageCName;
//    private String packageDName;
//    private String packageSnapshotName;
//    private String orgName = "bctestorg";
//    private Map<String, String> envVariables;
//
//    private static final String DEFAULT_PKG_NAME = "my_package";
//    private static final String PROJECT_A = "projectA";
//    private static final String PROJECT_B = "projectB";
//    private static final String PROJECT_C = "projectC";
//    private static final String PROJECT_D = "projectD";
//    private static final String PROJECT_SNAPSHOT = "projectSnapshot";
//
//    @BeforeClass()
//    public void setUp() throws IOException, InterruptedException {
//        TestUtils.setupDistributions();
//        tempHomeDirectory = Files.createTempDirectory("bal-test-integration-packaging-home-");
//        tempWorkspaceDirectory = Files.createTempDirectory("bal-test-integration-packaging-workspace-");
//        createSettingToml(tempHomeDirectory);
//        envVariables = TestUtils.addEnvVariables(getEnvVariables(), tempHomeDirectory);
//
//        // Copy test resources to temp workspace directory
//        try {
//            URI testResourcesURI = Objects.requireNonNull(getClass().getClassLoader().getResource("central")).toURI();
//            Files.walkFileTree(Paths.get(testResourcesURI),
//                               new CentralTest.Copy(Paths.get(testResourcesURI), this.tempWorkspaceDirectory));
//        } catch (URISyntaxException e) {
//            Assert.fail("error loading resources");
//        }
//
//        // Get random package names
//        do {
//            String randomString = randomPackageName(10);
//            this.packageAName = TEST_PREFIX + randomString + "_" + PROJECT_A;
//            this.packageBName = TEST_PREFIX + randomString + "_" + PROJECT_B;
//            this.packageCName = TEST_PREFIX + randomString + "_" + PROJECT_C;
//            this.packageDName = TEST_PREFIX + randomString + "_" + PROJECT_D;
//            this.packageSnapshotName = TEST_PREFIX + randomString + "_" + PROJECT_SNAPSHOT;
//        } while (isPkgAvailableInCentral(this.packageAName, tempWorkspaceDirectory, envVariables)
//                || isPkgAvailableInCentral(this.packageBName, tempWorkspaceDirectory, envVariables)
//                || isPkgAvailableInCentral(this.packageCName, tempWorkspaceDirectory, envVariables)
//                || isPkgAvailableInCentral(this.packageDName, tempWorkspaceDirectory, envVariables)
//                || isPkgAvailableInCentral(this.packageSnapshotName, tempWorkspaceDirectory, envVariables));
//
//        isPkgAvailableInCentral(this.packageAName, tempWorkspaceDirectory, envVariables);
//
//        // Update Ballerina.toml files with new package names"my_package"
//        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_A).resolve(BALLERINA_TOML), DEFAULT_PKG_NAME,
//                        this.packageAName);
//        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_B).resolve(BALLERINA_TOML), DEFAULT_PKG_NAME,
//                        this.packageBName);
//        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_C).resolve(BALLERINA_TOML), DEFAULT_PKG_NAME,
//                        this.packageCName);
//        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_D).resolve(BALLERINA_TOML), DEFAULT_PKG_NAME,
//                        this.packageDName);
//      updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_SNAPSHOT).resolve(BALLERINA_TOML), DEFAULT_PKG_NAME,
//                        this.packageSnapshotName);
//        // Update imports
//        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_C).resolve(MAIN_BAL), "<PKG_A>",
//                        this.packageAName);
//        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_C).resolve(MAIN_BAL), "<PKG_B>",
//                        this.packageBName);
//        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_D).resolve(MAIN_BAL), "<PKG_C>",
//                        this.packageCName);
//    }
//
//    @Test(description = "Build package A with a native lib dependency")
//    public void testBuildPackageA() throws IOException, InterruptedException {
//        Process build = executePackCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_A),
//                                            new LinkedList<>(), this.envVariables);
//        String buildErrors = getString(build.getErrorStream());
//        if (!buildErrors.isEmpty()) {
//            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
//        }
//
//        String buildOutput = getString(build.getInputStream());
//        if (!buildOutput.contains(getGenerateBalaLog(orgName, this.packageAName, ANY_PLATFORM, COMMON_VERSION))) {
//            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getGenerateBalaLog(orgName, this.packageAName, ANY_PLATFORM,
//                                                                         COMMON_VERSION));
//        }
//
//        Assert.assertTrue(
//                getBalaPath(this.tempWorkspaceDirectory.resolve(PROJECT_A), orgName, this.packageAName, ANY_PLATFORM,
//                            COMMON_VERSION).toFile().exists());
//    }
//
//    @Test(description = "Push package A to central", dependsOnMethods = "testBuildPackageA")
//    public void testPushPackageA() throws IOException, InterruptedException {
//        Process build = executePushCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_A),
//                                       new LinkedList<>(), this.envVariables);
//        String buildErrors = getString(build.getErrorStream());
//        if (!buildErrors.isEmpty()) {
//            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
//        }
//
//        String buildOutput = getString(build.getInputStream());
//        if (!buildOutput.contains(getPushedToCentralLog(orgName, packageAName))) {
//            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getPushedToCentralLog(orgName, packageAName));
//        }
//    }
//
//    @Test(description = "Build package B which has java11 platform dependency")
//    public void testBuildPackageB() throws IOException, InterruptedException {
//        Process build = executePackCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_B),
//                                       new LinkedList<>(), this.envVariables);
//
//        String buildErrors = getString(build.getErrorStream());
//        if (!buildErrors.isEmpty()) {
//            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
//        }
//
//        String buildOutput = getString(build.getInputStream());
//        if (!buildOutput.contains(getGenerateBalaLog(orgName, this.packageBName, JAVA11_PLATFORM, COMMON_VERSION))) {
//            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getGenerateBalaLog(orgName, this.packageBName, JAVA11_PLATFORM,
//                                                                         COMMON_VERSION));
//        }
//        Assert.assertTrue(
//              getBalaPath(this.tempWorkspaceDirectory.resolve(PROJECT_B), orgName, this.packageBName, JAVA11_PLATFORM,
//                            COMMON_VERSION).toFile().exists());
//    }
//
//    @Test(description = "Build package C which depends on Package A and B",
//            dependsOnMethods = { "testPushPackageA", "testBuildPackageB" })
//    public void testBuildPackageC() throws IOException, InterruptedException {
//        String expectedMsg = "cannot resolve module '" + orgName + "/" + this.packageBName + " as pkgB'";
//        String unexpectedMsg = "cannot resolve module '" + orgName + "/" + this.packageAName + " as pkgA'";
//
//        Process build = executePackCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_C),
//                                       new LinkedList<>(), this.envVariables);
//        String buildErrors = getString(build.getErrorStream());
//        if (buildErrors.isEmpty()) {
//            Assert.fail("build output should contain errors.");
//        }
//        if (buildErrors.contains(unexpectedMsg)) {
//            Assert.fail("build output should not contain unexpected message:" + unexpectedMsg);
//        }
//        if (!buildErrors.contains(expectedMsg)) {
//            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedMsg);
//        }
//    }
//
//    @Test(description = "Push package B to central", dependsOnMethods = "testBuildPackageC")
//    public void testPushPackageB() throws IOException, InterruptedException {
//        Process build = executePushCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_B),
//                                       new LinkedList<>(), this.envVariables);
//        String buildErrors = getString(build.getErrorStream());
//        if (!buildErrors.isEmpty()) {
//            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
//        }
//
//        String buildOutput = getString(build.getInputStream());
//        if (!buildOutput.contains(getPushedToCentralLog(orgName, this.packageBName))) {
//            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getPushedToCentralLog(orgName, this.packageBName));
//        }
//    }
//
//    @Test(description = "Build package C after pushing Package B", dependsOnMethods = "testPushPackageB")
//    public void testBuildPackageCAgain() throws IOException, InterruptedException {
//        Process build = executePackCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_C),
//                                       new LinkedList<>(), this.envVariables);
//
//        String buildErrors = getString(build.getErrorStream());
//        if (!buildErrors.isEmpty()) {
//            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
//        }
//
//        String buildOutput = getString(build.getInputStream());
//        if (!buildOutput.contains(getGenerateBalaLog(orgName, this.packageCName, ANY_PLATFORM, COMMON_VERSION))) {
//            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getGenerateBalaLog(orgName, this.packageCName, ANY_PLATFORM,
//                                                                         COMMON_VERSION));
//        }
//
//        Assert.assertTrue(
//                getBalaPath(this.tempWorkspaceDirectory.resolve(PROJECT_C), orgName, this.packageCName, ANY_PLATFORM,
//                            COMMON_VERSION).toFile().exists());
//    }
//
//    @Test(description = "Push package C to central", dependsOnMethods = "testBuildPackageCAgain")
//    public void testPushPackageC() throws IOException, InterruptedException {
//        Process build = executePushCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_C),
//                                       new LinkedList<>(), this.envVariables);
//        String buildErrors = getString(build.getErrorStream());
//        if (!buildErrors.isEmpty()) {
//            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
//        }
//
//        String buildOutput = getString(build.getInputStream());
//        if (!buildOutput.contains(getPushedToCentralLog(orgName, this.packageCName))) {
//            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + getPushedToCentralLog(orgName, this.packageCName));
//        }
//    }
//
//    @Test(description = "Build and run package D which depends on Package C", dependsOnMethods = "testPushPackageC",
//          enabled = false)
//    public void testBuildAndRunPackageD() throws IOException, InterruptedException {
//        Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_D),
//                                       new LinkedList<>(), this.envVariables);
//
//        String buildErrors = getString(build.getErrorStream());
//        if (!buildErrors.isEmpty()) {
//            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
//        }
//
//        Assert.assertTrue(
//                getExecutableJarPath(this.tempWorkspaceDirectory.resolve(PROJECT_D), this.packageDName)
//                        .toFile().exists());
//
//        Process run = executeCommand("run", DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_D),
//                                     new LinkedList<>(), this.envVariables);
//        String runErrors = getString(run.getInputStream());
//        if (!runErrors.isEmpty()) {
//            Assert.fail(OUTPUT_CONTAIN_ERRORS + runErrors);
//        }
//    }
//
//    @Test(description = "Build package with pre-release version")
//    public void testBuildSnapshotPackage() throws IOException, InterruptedException {
//        String snapshotVersion = "1.0.0-snapshot";
//        Process build = executePackCommand(DISTRIBUTION_FILE_NAME,
//                                            this.tempWorkspaceDirectory.resolve(PROJECT_SNAPSHOT),
//                                            new LinkedList<>(),
//                                            this.envVariables);
//
//        String buildErrors = getString(build.getErrorStream());
//        if (!buildErrors.isEmpty()) {
//            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
//        }
//
//        String buildOutput = getString(build.getInputStream());
//        if (!buildOutput.contains(getGenerateBalaLog(
//                orgName, this.packageSnapshotName, ANY_PLATFORM, snapshotVersion))) {
//            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG
//                              + getGenerateBalaLog(orgName, this.packageSnapshotName, ANY_PLATFORM, snapshotVersion));
//        }
//
//        Assert.assertTrue(
//                getBalaPath(this.tempWorkspaceDirectory.resolve(PROJECT_SNAPSHOT), orgName, this.packageSnapshotName,
//                            ANY_PLATFORM, snapshotVersion).toFile().exists());
//    }
//
//    @Test(description = "Push package with pre-release version to central",
//            dependsOnMethods = "testBuildSnapshotPackage")
//    public void testPushSnapshotPackage() throws IOException, InterruptedException {
//        Process build = executePushCommand(DISTRIBUTION_FILE_NAME,
//                                           this.tempWorkspaceDirectory.resolve(PROJECT_SNAPSHOT),
//                                           new LinkedList<>(),
//                                           this.envVariables);
//        String buildErrors = getString(build.getErrorStream());
//        if (!buildErrors.isEmpty()) {
//            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
//        }
//
//        String buildOutput = getString(build.getInputStream());
//        String expectedMsg =
//                orgName + "/" + this.packageSnapshotName + ":1.0.0-snapshot pushed to central successfully";
//        if (!buildOutput.contains(expectedMsg)) {
//            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedMsg);
//        }
//    }
//
//    @Test(description = "Pull package with pre-release version from central",
//            dependsOnMethods = "testPushSnapshotPackage")
//    public void testPullSnapshotPackage() throws IOException, InterruptedException {
//        String pkg = orgName + "/" + this.packageSnapshotName + ":1.0.0-snapshot";
//
//        Process build = executePullCommand(DISTRIBUTION_FILE_NAME,
//                                           this.tempWorkspaceDirectory.resolve(PROJECT_SNAPSHOT),
//                                           new LinkedList<>(Collections.singletonList(pkg)),
//                                           this.envVariables);
//        String buildErrors = getString(build.getErrorStream());
//        if (!buildErrors.isEmpty()) {
//            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
//        }
//
//        String buildOutput = getString(build.getInputStream());
//        String expectedMsg = pkg + " pulled from central successfully";
//        if (!buildOutput.contains(expectedMsg)) {
//            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedMsg);
//        }
//    }
//
//    @AfterClass
//    private void cleanup() throws IOException {
//        deleteFiles(tempHomeDirectory);
//        deleteFiles(tempWorkspaceDirectory);
//    }
//
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
