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
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.Collections;
import java.util.LinkedList;

import static org.ballerina.devtools.cmd.TestUtils.DISTRIBUTIONS_DIR;
import static org.ballerina.devtools.cmd.TestUtils.MAVEN_VERSION;
import static org.ballerina.devtools.cmd.TestUtils.getExecutableJarPath;

/**
 * Tests related new command compiling.
 */
public class BuildNewCommandTest {

    private Path tempHomeDirectory;
    private ByteArrayOutputStream console;
    protected PrintStream printStream;

    public static final String DISTRIBUTION_FILE_NAME = "ballerina-" + MAVEN_VERSION;

    @BeforeClass()
    public void setUp() throws IOException {
        setupDistributions();
        TestUtils.createTempDirectories();
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

        TestUtils.executeCommand("build", new LinkedList<>(Collections.singletonList("project_name")));
        Assert.assertTrue(projectPath.resolve("target").resolve("bin").resolve("project_name.jar").toFile().exists());
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
        Assert.assertTrue(Files.exists(projectPath));

        TestUtils.executeCommand("build", new LinkedList<>(Collections.singletonList("lib_sample")));
        Assert.assertTrue(getExecutableJarPath(projectPath, "lib_sample").toFile().exists());
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
