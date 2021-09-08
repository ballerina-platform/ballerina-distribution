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

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static javax.swing.UIManager.getString;
import static org.ballerina.devtools.cmd.TestUtils.DISTRIBUTIONS_DIR;
import static org.ballerina.devtools.cmd.TestUtils.MAVEN_VERSION;
import static org.ballerina.devtools.cmd.TestUtils.distributionName;
import static org.ballerina.devtools.cmd.TestUtils.getExecutableJarPath;

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
    public void testCompilingNewCommandDefaultTempProject() throws IOException, InterruptedException {
        Path result = TestUtils.executeCommand("new", new LinkedList<>(Collections.singletonList("project_name")));
        Path projectPath = Paths.get(result.toString(), "project_name");
        Assert.assertTrue(Files.exists(projectPath));
        Assert.assertTrue(Files.exists(projectPath.resolve("Ballerina.toml")));

        List<String> args = new LinkedList<>();
        boolean success = TestUtils.executeBuild(distributionName, projectPath,args);
////        Assert.assertTrue(builldLog.toString().contains("Compiling source"));
        Assert.assertTrue(Files.isDirectory(projectPath.resolve("target").resolve("bin")));
//        Assert.assertTrue(Files.exists(projectPath.resolve("target").resolve("bin").resolve("project_name.jar")));
    }

    @Test(description = "Build package created from new command with main template")
    public void testCompilingNewCommandMainTempProject() throws IOException, InterruptedException {
        Path resultPath = TestUtils.executeCommand("new",
                new LinkedList(Arrays.asList("main_sample", "-t", "main")));
        Path projectPath = Paths.get(resultPath.toString(), "main_sample");
        Assert.assertTrue(Files.exists(projectPath));

        TestUtils.executeCommand("build", new LinkedList<>(Collections.singletonList("main_sample")));
        Assert.assertTrue(getExecutableJarPath(projectPath, "main_sample").toFile().exists());
    }

    @Test(description = "Build package created from new command with service template")
    public void testCompilingNewCommandServiceTempProject() throws IOException, InterruptedException {
        Path resultPath = TestUtils.executeCommand("new",
                new LinkedList(Arrays.asList("service_sample", "-t", "service")));
        Path projectPath = Paths.get(resultPath.toString(), "service_sample");
        Assert.assertTrue(Files.exists(projectPath));

        TestUtils.executeCommand("build", new LinkedList<>(Collections.singletonList("service_sample")));
        Assert.assertTrue(getExecutableJarPath(projectPath, "service_sample").toFile().exists());
    }

    @Test(description = "Build package created from new command with lib template")
    public void testCompilingNewCommandLibTempProject() throws IOException, InterruptedException {
        Path resultPath = TestUtils.executeCommand("new",
                new LinkedList(Arrays.asList("lib_sample", "-t", "lib")));
        Path projectPath = Paths.get(resultPath.toString(), "lib_sample");
        System.out.println("--------------");
        System.out.println(projectPath);
        System.out.println("---------------");
        System.out.println(resultPath.toString());
        System.out.println("---------------");

        Assert.assertTrue(Files.exists(projectPath));

        TestUtils.executeCommand("build", new LinkedList<>(Collections.singletonList("lib_sample")));
        Assert.assertTrue(getExecutableJarPath(projectPath, "lib_sample").toFile().exists());
    }

    @Test(description = "Create a new package with pulling a module from central")
    public void testNewCommandWithCentralPull() throws IOException, InterruptedException {
        List<String> buildArgs = new LinkedList<>();
        buildArgs.add("SamplePull");
        buildArgs.add("-t");
        buildArgs.add("admin/Sample:0.1.4");
        InputStream outputs = TestUtils.executeCommand("new", DISTRIBUTION_FILE_NAME, buildArgs);
        String generatedLog = readOutputLog(outputs);
        Assert.assertTrue(generatedLog.contains("Compiling source"));

//        Path projectPath = Paths.get(System.getProperty("user.dir")).resolve("SamplePull");
//        Assert.assertTrue(Files.exists(projectPath));
    }

//    @Test(description = "Create a new package with io module by pulling from central")
//    public void testNewCommandCentralPullWithoutVersion() throws IOException, InterruptedException {
//        List<String> buildArgs = new LinkedList<>();
//        buildArgs.add("SamplePullWithoutVersion");
//        buildArgs.add("-t");
//        buildArgs.add("ballerinax/livestorm");
//        InputStream outputs = TestUtils.executeNewCommand(DISTRIBUTION_FILE_NAME, buildArgs);
//        try (BufferedReader br = new BufferedReader(new InputStreamReader(outputs))) {
//
//            Stream<String> logLines = br.lines();
//            String generatedLog = logLines.collect(Collectors.joining("\n"));
//            logLines.close();
//
//            System.out.println(generatedLog);
//            Assert.assertTrue(generatedLog.contains("Created new Ballerina package 'SamplePullWithoutVersion'"));
//        }
//    }

    public String readOutputLog(InputStream outputs) throws IOException {
        try (BufferedReader br = new BufferedReader(new InputStreamReader(outputs))) {
            Stream<String> logLines = br.lines();
            String generatedLog = logLines.collect(Collectors.joining("\n"));
            logLines.close();
//            Assert.assertTrue(generatedLog.contains("Compiling source"));
            return generatedLog;
        }
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
