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
import static org.ballerina.devtools.central.CentralTestUtils.HOME_REPO_ENV_KEY;
import static org.ballerina.devtools.central.CentralTestUtils.createSettingToml;
import static org.ballerina.devtools.central.CentralTestUtils.deleteFiles;
import static org.ballerina.devtools.central.CentralTestUtils.getEnvVariables;
import static org.ballerina.devtools.central.CentralTestUtils.getString;
import static org.ballerina.devtools.central.CentralTestUtils.randomPackageName;
import static org.ballerina.devtools.central.CentralTestUtils.updateFileToken;
import static org.ballerina.devtools.utils.TestUtils.DISTRIBUTIONS_DIR;
import static org.ballerina.devtools.utils.TestUtils.MAVEN_VERSION;
import static org.ballerina.devtools.utils.TestUtils.executeCommand;

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
    private String orgName = "bc2testorg";
    private Map<String, String> envVariables;

    private static final String DISTRIBUTION_FILE_NAME = "ballerina-" + MAVEN_VERSION;
    private static final String PROJECT_A = "projectA";
    private static final String PROJECT_B = "projectB";
    private static final String PROJECT_C = "projectC";
    private static final String PROJECT_D = "projectD";

    @BeforeClass()
    public void setUp() throws IOException {
        setupDistributions();

        tempHomeDirectory = Files.createTempDirectory("bal-test-integration-packaging-home-");
        tempWorkspaceDirectory = Files.createTempDirectory("bal-test-integration-packaging-workspace-");
        createSettingToml(tempHomeDirectory);
        envVariables = addEnvVariables(getEnvVariables());

        // Get random package names
        String randomString = randomPackageName(10);
        this.packageAName = "test_" + randomString + "_" + PROJECT_A;
        this.packageBName = "test_" + randomString + "_" + PROJECT_B;
        this.packageCName = "test_" + randomString + "_" + PROJECT_C;
        this.packageDName = "test_" + randomString + "_" + PROJECT_D;

        // Copy test resources to temp workspace directory
        try {
            URI testResourcesURI = Objects.requireNonNull(getClass().getClassLoader().getResource("central")).toURI();
            Files.walkFileTree(Paths.get(testResourcesURI),
                               new CentralTest.Copy(Paths.get(testResourcesURI), this.tempWorkspaceDirectory));
        } catch (URISyntaxException e) {
            Assert.fail("error loading resources");
        }

        // Update Ballerina.toml files with new package names
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_A).resolve("Ballerina.toml"), "my_package",
                        this.packageAName);
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_B).resolve("Ballerina.toml"), "my_package",
                        this.packageBName);
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_C).resolve("Ballerina.toml"), "my_package",
                        this.packageCName);
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_D).resolve("Ballerina.toml"), "my_package",
                        this.packageDName);
        // Update imports
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_C).resolve("main.bal"), "<PKG_A>",
                        this.packageAName);
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_C).resolve("main.bal"), "<PKG_B>",
                        this.packageBName);
        updateFileToken(this.tempWorkspaceDirectory.resolve(PROJECT_D).resolve("main.bal"), "<PKG_C>",
                        this.packageCName);
    }

    @Test(description = "Build package A with a native lib dependency")
    public void testBuildPackageA() throws IOException, InterruptedException {
        String expectedMsg = "Generating executable\n" + "\ttarget/bin/" + this.packageAName + ".jar";
        Process build = executeCommand("build", DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_A),
                                       new LinkedList<>(), this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail("build output contain errors:" + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(expectedMsg)) {
            Assert.fail("build output does not contain expected message:" + expectedMsg);
        }

        Assert.assertTrue(this.tempWorkspaceDirectory.resolve(PROJECT_A).resolve("target").resolve("bin")
                                  .resolve(this.packageAName + ".jar").toFile().exists());
    }

    @Test(description = "Push package A to central", dependsOnMethods = "testBuildPackageA")
    public void testPushPackageA() throws IOException, InterruptedException {
        String expectedMsg = orgName + "/" + packageAName + ":1.0.0 pushed to central successfully";
        Process build = executeCommand("push", DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_A),
                                       new LinkedList<>(), this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail("build output contain errors:" + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(expectedMsg)) {
            Assert.fail("build output does not contain expected message:" + expectedMsg);
        }
    }

    @Test(description = "Build package B")
    public void testBuildPackageB() throws IOException, InterruptedException {
        String expectedMsg = "Generating executable\n" + "\ttarget/bin/" + this.packageBName + ".jar";
        Process build = executeCommand("build", DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_B),
                                       new LinkedList<>(), this.envVariables);

        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail("build output contain errors:" + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(expectedMsg)) {
            Assert.fail("build output does not contain expected message:" + expectedMsg);
        }

        Assert.assertTrue(this.tempWorkspaceDirectory.resolve(PROJECT_B).resolve("target").resolve("bin")
                                  .resolve(this.packageBName + ".jar").toFile().exists());
    }

    @Test(description = "Build package C which depends on Package A and B",
            dependsOnMethods = { "testPushPackageA", "testBuildPackageB" })
    public void testBuildPackageC() throws IOException, InterruptedException {
        String expectedMsg = "cannot resolve module '" + orgName + "/" + this.packageBName + " as pkgB'";
        String unexpectedMsg = "cannot resolve module '" + orgName + "/" + this.packageAName + " as pkgA'";

        Process build = executeCommand("build", DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_C),
                                       new LinkedList<>(), this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (buildErrors.isEmpty()) {
            Assert.fail("build output should contain errors.");
        }
        if (buildErrors.contains(unexpectedMsg)) {
            Assert.fail("build output should not contain unexpected message:" + unexpectedMsg);
        }
        if (!buildErrors.contains(expectedMsg)) {
            Assert.fail("build output does not contain expected message:" + expectedMsg);
        }
    }

    @Test(description = "Push package B to central", dependsOnMethods = "testBuildPackageC")
    public void testPushPackageB() throws IOException, InterruptedException {
        String expectedMsg = orgName + "/" + packageBName + ":1.0.0 pushed to central successfully";
        Process build = executeCommand("push", DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_B),
                                       new LinkedList<>(), this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail("build output contain errors:" + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(expectedMsg)) {
            Assert.fail("build output does not contain expected message:" + expectedMsg);
        }
    }

    @Test(description = "Build package C after pushing Package B", dependsOnMethods = "testPushPackageB")
    public void testBuildPackageCAgain() throws IOException, InterruptedException {
        String expectedMsg = "Generating executable\n" + "\ttarget/bin/" + this.packageCName + ".jar";
        Process build = executeCommand("build", DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_C),
                                       new LinkedList<>(), this.envVariables);

        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail("build output contain errors:" + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(expectedMsg)) {
            Assert.fail("build output does not contain expected message:" + expectedMsg);
        }

        Assert.assertTrue(this.tempWorkspaceDirectory.resolve(PROJECT_C).resolve("target").resolve("bin")
                                  .resolve(this.packageCName + ".jar").toFile().exists());
    }

    @Test(description = "Push package C to central", dependsOnMethods = "testBuildPackageCAgain")
    public void testPushPackageC() throws IOException, InterruptedException {
        String expectedMsg = orgName + "/" + packageCName + ":1.0.0 pushed to central successfully";
        Process build = executeCommand("push", DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_C),
                                       new LinkedList<>(), this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail("build output contain errors:" + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(expectedMsg)) {
            Assert.fail("build output does not contain expected message:" + expectedMsg);
        }
    }

    @Test(description = "Build and run package D which depends on Package C", dependsOnMethods = "testPushPackageC")
    public void testBuildAndRunPackageD() throws IOException, InterruptedException {
        String expectedMsg = "Generating executable\n" + "\ttarget/bin/" + this.packageDName + ".jar";
        Process build = executeCommand("build", DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_D),
                                       new LinkedList<>(), this.envVariables);

        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail("build output contain errors:" + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        if (!buildOutput.contains(expectedMsg)) {
            Assert.fail("build output does not contain expected message:" + expectedMsg);
        }

        Assert.assertTrue(this.tempWorkspaceDirectory.resolve(PROJECT_C).resolve("target").resolve("bin")
                                  .resolve(this.packageCName + ".jar").toFile().exists());

        String runExpectedMsg = "Hello World:110";
        Process run = executeCommand("run", DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PROJECT_D),
                                     new LinkedList<>(Collections.singletonList(".")), this.envVariables);
        String runOutput = getString(run.getInputStream());
        if (!runOutput.contains(runExpectedMsg)) {
            Assert.fail("run output does not contain expected message:" + runExpectedMsg);
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
        envVariables.put(HOME_REPO_ENV_KEY, tempHomeDirectory.toString());
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
