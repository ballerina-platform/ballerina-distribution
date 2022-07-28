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
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.LinkedList;
import java.util.List;

import static org.ballerina.devtools.cmd.TestUtils.*;

/**
 * Tests related new command compiling.
 */
public class BuildNewCommandTest {

    public static final String DISTRIBUTION_FILE_NAME = "ballerina-" + MAVEN_VERSION + "-" + CODE_NAME;
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
