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

import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.LinkedList;
import java.util.List;

import static org.ballerina.devtools.cmd.TestUtils.DISTRIBUTIONS_DIR;
import static org.ballerina.devtools.cmd.TestUtils.MAVEN_VERSION;
import static org.ballerina.devtools.cmd.TestUtils.distributionName;

/**
 * Tests related new command compiling.
 */
public class BuildNewCommandTest {

    public static final String DISTRIBUTION_FILE_NAME = "ballerina-" + MAVEN_VERSION;
    public static final String WHITESPACE_PATTERN = "\\s+";

    private Path tempHomeDirectory;
    private Path tempWorkspaceDirectory;
    private static Path sourceDirectory;
    private ByteArrayOutputStream console;
    protected PrintStream printStream;

    @BeforeClass()
    public void setUp() throws IOException {
        setupDistributions();
        TestUtils.createTempDirectories();
        tempWorkspaceDirectory = Files.createTempDirectory("bal-test-integration-packaging-workspace-");
    }

    @BeforeMethod
    public void beforeMethod() {
        this.console = new ByteArrayOutputStream();
        this.printStream = new PrintStream(this.console);
    }

    @Test(description = "Build package created from new command with default template")
    public void testCompilingNewCommandDefaultTempProject() throws IOException {
        List<String> args = new LinkedList<>();
        args.add("project_sample");
        Path newOutputPath = TestUtils.executeNew(distributionName, args);
        Assert.assertTrue(Files.isDirectory(newOutputPath.resolve("project_sample")));
        Assert.assertTrue(Files.exists(newOutputPath.resolve("project_sample").resolve("Ballerina.toml")));

        List<String> buildArgs = new LinkedList<>();
        String buildOutput = TestUtils.executeBuild(distributionName, newOutputPath.resolve("project_sample"), buildArgs);
        Assert.assertTrue(buildOutput.contains("Compiling source"));
        Assert.assertTrue(buildOutput.contains("Generating executable"));
    }

    @Test(description = "Build package created from new command with main template")
    public void testCompilingNewCommandMainTempProject() throws IOException {
        List<String> args = new LinkedList<>();
        args.add("main_sample");
        args.add("-t");
        args.add("main");
        Path newOutputPath = TestUtils.executeNew(distributionName, args);
        Assert.assertTrue(Files.isDirectory(newOutputPath.resolve("main_sample")));
        Assert.assertTrue(Files.exists(newOutputPath.resolve("main_sample").resolve("Ballerina.toml")));

        List<String> buildArgs = new LinkedList<>();
        String buildOutput = TestUtils.executeBuild(distributionName, newOutputPath.resolve("main_sample"), buildArgs);
        Assert.assertTrue(buildOutput.contains("Compiling source"));
        Assert.assertTrue(buildOutput.contains("Generating executable"));
    }

    @Test(description = "Build package created from new command with service template")
    public void testCompilingNewCommandServiceTempProject() throws IOException {
        List<String> args = new LinkedList<>();
        args.add("service_sample");
        args.add("-t");
        args.add("service");
        Path newOutputPath = TestUtils.executeNew(distributionName, args);
        Assert.assertTrue(Files.isDirectory(newOutputPath.resolve("service_sample")));
        Assert.assertTrue(Files.exists(newOutputPath.resolve("service_sample").resolve("Ballerina.toml")));

        List<String> buildArgs = new LinkedList<>();
        String buildOutput = TestUtils.executeBuild(distributionName, newOutputPath.resolve("service_sample"), buildArgs);
        Assert.assertTrue(buildOutput.contains("Compiling source"));
        Assert.assertTrue(buildOutput.contains("Generating executable"));
    }

    @Test(description = "Build package created from new command with lib template")
    public void testCompilingNewCommandLibTempProject() throws IOException {
        List<String> args = new LinkedList<>();
        args.add("lib_sample");
        args.add("-t");
        args.add("lib");
        Path newOutputPath = TestUtils.executeNew(distributionName, args);
        Assert.assertTrue(Files.isDirectory(newOutputPath.resolve("lib_sample")));
        Assert.assertTrue(Files.exists(newOutputPath.resolve("lib_sample").resolve("Ballerina.toml")));

        List<String> buildArgs = new LinkedList<>();
        String buildOutput = TestUtils.executeBuild(distributionName, newOutputPath.resolve("lib_sample"), buildArgs);
        Assert.assertTrue(buildOutput.contains("Compiling source"));
        Assert.assertTrue(buildOutput.contains("Generating executable"));
    }

    @Test(description = "Create a new package by pulling a module from central")
    public void testNewCommandWithCentralPull() throws IOException {
        List<String> args = new LinkedList<>();
        args.add("project");
        args.add("-t");
        args.add("admin/Sample:0.1.2");
        Path newOutputPath = TestUtils.executeNew(distributionName, args);
        Assert.assertTrue(Files.isDirectory(newOutputPath.resolve("project")));
        Assert.assertTrue(Files.exists(newOutputPath.resolve("project").resolve("Ballerina.toml")));
        Assert.assertTrue(Files.exists(newOutputPath.resolve("project").resolve("Package.md")));
        String tomlContent = Files.readString(
                newOutputPath.resolve("project").resolve("Ballerina.toml"), StandardCharsets.UTF_8);
        Assert.assertTrue(tomlContent.contains("version = \"0.1.2\""));

        List<String> buildArgs = new LinkedList<>();
        String buildOutput = TestUtils.executeBuild(distributionName, newOutputPath.resolve("project"), buildArgs);
        Assert.assertTrue(buildOutput.contains("Compiling source"));
        Assert.assertTrue(buildOutput.contains("Generating executable"));
    }

    @Test(description = "Create a new package by pulling a module from central without specifying version")
    public void testNewCommandCentralPullWithoutVersion() throws IOException {
        List<String> args = new LinkedList<>();
        args.add("project_without_version");
        args.add("-t");
        args.add("admin/Sample");
        Path newOutputPath = TestUtils.executeNew(distributionName, args);
        Assert.assertTrue(Files.isDirectory(newOutputPath.resolve("project_without_version")));
        Assert.assertTrue(Files.exists(newOutputPath.resolve("project_without_version").resolve("Ballerina.toml")));
        Assert.assertTrue(Files.exists(newOutputPath.resolve("project_without_version").resolve("Package.md")));

        String tomlContent = Files.readString(
                newOutputPath.resolve("project_without_version").resolve("Ballerina.toml"), StandardCharsets.UTF_8);
        Assert.assertTrue(tomlContent.contains("version = \"0.1.5\""));
        Assert.assertTrue(tomlContent.contains("template = true"));

        List<String> buildArgs = new LinkedList<>();
        String buildOutput = TestUtils.executeBuild(distributionName, newOutputPath.resolve("project_without_version"), buildArgs);
        Assert.assertTrue(buildOutput.contains("Compiling source"));
        Assert.assertTrue(buildOutput.contains("Generating executable"));
    }

    @Test(description = "Create a new package by pulling a module without template tagging from central")
    public void testNewCommandCentralPullPkgWithTemplateUntagged() throws IOException {
        List<String> args = new LinkedList<>();
        args.add("project_with_twitter_module");
        args.add("-t");
        args.add("ballerinax/twitter:1.0.0");
        Path newOutputPath = TestUtils.executeNew(distributionName, args);
        Assert.assertTrue(Files.exists(newOutputPath.resolve("project_with_twitter_module")));
        Assert.assertFalse(Files.exists(newOutputPath.resolve("project_with_twitter_module").resolve("Ballerina.toml")));
    }

    @Test(description = "Create a new package by pulling a module with platform dependencies from central")
    public void testNewCommandCentralPullWithPlatformDependencies() throws IOException {
        List<String> args = new LinkedList<>();
        args.add("project_with_platform_dep");
        args.add("-t");
        args.add("admin/lib_project:0.1.0");
        Path newOutputPath = TestUtils.executeNew(distributionName, args);
        Assert.assertTrue(Files.exists(newOutputPath.resolve("project_with_platform_dep").resolve("Ballerina.toml")));
        String tomlContent = Files.readString(
                newOutputPath.resolve("project_with_platform_dep").resolve("Ballerina.toml"), StandardCharsets.UTF_8);
        Assert.assertTrue(tomlContent.contains("artifactId = \"snakeyaml\""));
        Assert.assertTrue(tomlContent.contains("groupId = \"org.yaml\""));
        Assert.assertTrue(tomlContent.contains("version = \"1.9\""));

        List<String> buildArgs = new LinkedList<>();
        String buildOutput = TestUtils.executeBuild(distributionName, newOutputPath.resolve("project_with_platform_dep"), buildArgs);
        Assert.assertTrue(buildOutput.contains("Compiling source"));
        Assert.assertTrue(buildOutput.contains("Generating executable"));
    }

    @AfterClass
    private void cleanup() throws IOException {
        TestUtils.deleteFiles();
    }

    /**
     * Clean and set up distributions.
     */
    private void setupDistributions() throws IOException {
        TestUtils.cleanDistribution();
        TestUtils.prepareDistribution(DISTRIBUTIONS_DIR.resolve(DISTRIBUTION_FILE_NAME + ".zip"));
    }
}
