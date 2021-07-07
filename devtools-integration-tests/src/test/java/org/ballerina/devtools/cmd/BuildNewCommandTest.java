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
import java.nio.file.*;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.*;

import static javax.swing.UIManager.getString;
import static org.ballerina.devtools.cmd.TestUtils.*;

/**
 * Tests related new command compiling.
 */
public class BuildNewCommandTest {

    private Path tempHomeDirectory;
    private Path tempWorkspaceDirectory;
    private Map<String, String> envVariables;
    private ByteArrayOutputStream console;
    protected PrintStream printStream;

    private static final String DISTRIBUTION_FILE_NAME = "ballerina-" + MAVEN_VERSION;

    @BeforeClass()
    public void setUp() throws IOException, InterruptedException {
        setupDistributions();

        tempHomeDirectory = Files.createTempDirectory("bal-test-integration-packaging-home-");
        tempWorkspaceDirectory = Files.createTempDirectory("bal-test-integration-packaging-workspace-");
        createSettingToml(tempHomeDirectory);
        envVariables = addEnvVariables(getEnvVariables());
        this.console = new ByteArrayOutputStream();
        this.printStream = new PrintStream(this.console);
    }

    @BeforeMethod
    public void beforeMethod() {
        this.console = new ByteArrayOutputStream();
        this.printStream = new PrintStream(this.console);
    }

    protected String readOutput() throws IOException {
        return readOutput(false);
    }

    protected String readOutput(boolean silent) throws IOException {
        String output = "";
        output = console.toString();
        console.close();
        console = new ByteArrayOutputStream();
        printStream = new PrintStream(console);
        if (!silent) {
            PrintStream out = System.out;
            out.println(output);
        }
        return output;
    }

    @Test(description = "Build package created from new command with default template")
    public void testCompilingNewCommandDefaultTempProject() throws IOException, InterruptedException {
        Process newCommand = executeNewCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new LinkedList<>(Collections.singletonList("project_name")), this.envVariables);

        Path packageDir = this.tempWorkspaceDirectory.resolve("project_name");
        Assert.assertTrue(Files.exists(packageDir));

        Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new LinkedList<>(Collections.singletonList("project_name")), this.envVariables);

        Assert.assertTrue(packageDir.resolve("target").resolve("bin").resolve("project_name.jar").toFile().exists());
    }

    @Test(description = "Build package created from new command with main template")
    public void testCompilingNewCommandMainTempProject() throws IOException, InterruptedException {
        Process newCommand = executeNewCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new LinkedList<String>(Arrays.asList("main_sample", "-t", "main")), this.envVariables);

        Path packageDir = this.tempWorkspaceDirectory.resolve("main_sample");
        Assert.assertTrue(Files.exists(packageDir));

        Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new LinkedList<>(Collections.singletonList("main_sample")), this.envVariables);

        Assert.assertTrue(packageDir.resolve("target").resolve("bin").resolve("main_sample.jar").toFile().exists());
    }

    @Test(description = "Build package created from new command with service template")
    public void testCompilingNewCommandServiceTempProject() throws IOException, InterruptedException {
        Process newCommand = executeNewCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new LinkedList<String>(Arrays.asList("service_sample", "-t", "service")), this.envVariables);

        Path packageDir = this.tempWorkspaceDirectory.resolve("service_sample");
        Assert.assertTrue(Files.exists(packageDir));

        Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new LinkedList<>(Collections.singletonList("service_sample")), this.envVariables);

        Assert.assertTrue(packageDir.resolve("target").resolve("bin").resolve("service_sample.jar").toFile().exists());
    }

    @Test(description = "Build package created from new command with service template")
    public void testCompilingNewCommandLibTempProject() throws IOException, InterruptedException {
        Process newCommand = executeNewCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new LinkedList<String>(Arrays.asList("lib_sample", "-t", "lib")), this.envVariables);

        Path packageDir = this.tempWorkspaceDirectory.resolve("lib_sample");
        Assert.assertTrue(Files.exists(packageDir));

        Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new LinkedList<>(Collections.singletonList("lib_sample")), this.envVariables);

        Assert.assertTrue(packageDir.resolve("target").resolve("bin").resolve("lib_sample.jar").toFile().exists());
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
}
