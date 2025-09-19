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

package org.ballerinalang.distribution.test;

import org.ballerinalang.distribution.utils.TestUtils;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * Test ballerina commands.
 */
public class BallerinaCommandTest {
    private static final String DIST_NAME = "ballerina-" + TestUtils.MAVEN_VERSION;
    public static final String VERSION = System.getProperty("maven.version");
    public static final String SHORT_VERSION = System.getProperty("short.version");
    private static final String SPEC_VERSION = System.getProperty("spec.version");
    public static final String VERSION_DISPLAY_TEXT = System.getProperty("version.display.text");
    private static final String TOOL_VERSION = System.getProperty("tool.version");
    private static final String path = TestUtils.TEST_DISTRIBUTION_PATH.resolve(DIST_NAME).resolve("bin").resolve("bal").toString();

    @BeforeClass
    public void setupDistributions() throws IOException {
        TestUtils.cleanDistribution();
        TestUtils.prepareDistribution(TestUtils.DISTRIBUTIONS_DIR.resolve(DIST_NAME + ".zip"));
    }

    @Test(description = "Execute smoke testing to verify installation.")
    public void testVersionCommand() throws IOException {
        TestUtils.testInstallation(path, VERSION, SPEC_VERSION, TOOL_VERSION, VERSION_DISPLAY_TEXT);
    }

    @Test(description = "Execute smoke testing to verify build command.", dependsOnMethods = {"testVersionCommand"})
    public void testBuildCommand() throws IOException {
        String projectName = "project1";
        String moduleName = "module1";

        TestUtils.executeCommand(path + " new " + projectName);
        TestUtils.executeCommand("cd " + projectName + " && " + path + " add " + moduleName);
        String actualOutput = TestUtils.executeCommand("cd " + projectName + " && " + path + " build");

        Assert.assertTrue(actualOutput.contains("Compiling source"));
        Assert.assertTrue(actualOutput.contains("Generating executable"));
    }

    @Test(description = "Execute smoke testing to verify dist commands.", dependsOnMethods = {"testVersionCommand"})
    public void testDistCommands() throws IOException {
        Path ballerinaHome = Paths.get(TestUtils.getUserHome()).resolve(".ballerina").resolve("ballerina-version");
        // test bal dist list
        String actualOutput = TestUtils.executeCommand(path + " dist list");
        Assert.assertTrue(actualOutput.contains("Distributions available locally:"));
        Assert.assertTrue(actualOutput.contains("Distributions available remotely:"));
        Assert.assertTrue(actualOutput.contains("1.* channel"));
        Assert.assertTrue(actualOutput.contains("1.0.0"));
        Assert.assertTrue(actualOutput.contains("1.1.0"));
        Assert.assertTrue(actualOutput.contains("1.2.0"));
        Assert.assertTrue(actualOutput.contains("Swan Lake channel"));
        Assert.assertTrue(actualOutput.contains("slp1"));
        Assert.assertTrue(actualOutput.contains("slp8"));

        // test bal dist pull and fetching dependencies
        actualOutput = TestUtils.executeCommand(path + " dist pull 1.2.3");
        Assert.assertTrue(actualOutput.contains("Fetching the '1.2.3' distribution from the remote server..."));
        Assert.assertTrue(actualOutput.contains("Fetching the dependencies for '1.2.3' from the remote server..."));
        Assert.assertTrue(actualOutput.contains("Downloading jdk8u202-b08-jre"));
        Assert.assertTrue(actualOutput.contains("'1.2.3' successfully set as the active distribution"));
        TestUtils.testInstallation(path, "1.2.3", "2020R1", TOOL_VERSION, "1.2.3");

        // test bal dist update
        actualOutput = TestUtils.executeCommand(path + " dist update");
        Assert.assertTrue(actualOutput.contains("Fetching the latest patch distribution for 'jballerina-1.2.3' from the remote server..."));
        Assert.assertTrue(actualOutput.contains("Successfully set the latest patch distribution"));
        Assert.assertEquals(TestUtils.getContent(ballerinaHome).split("-")[1].trim(),
                actualOutput.split("Downloading ")[1].split(" ")[0]);
        actualOutput = TestUtils.executeCommand(path + " dist update");
        Assert.assertTrue(actualOutput.contains("is already the active distribution"));

        // test bal dist use
        actualOutput = TestUtils.executeCommand(path + " dist use 1.2.3");
        Assert.assertTrue(actualOutput.contains("'1.2.3' successfully set as the active distribution"));
        TestUtils.testInstallation(path, "1.2.3", "2020R1", TOOL_VERSION, "1.2.3");
        actualOutput = TestUtils.executeCommand(path + " dist pull slp7");
        Assert.assertTrue(actualOutput.contains("Fetching the 'slp7' distribution from the remote server..."));
        Assert.assertTrue(actualOutput.contains("Fetching the dependencies for 'slp7' from the remote server..."));
        Assert.assertTrue(actualOutput.contains("Downloading jdk-21.0.5+11-jre"));
        Assert.assertTrue(actualOutput.contains("'slp7' successfully set as the active distribution"));
        TestUtils.testInstallation(path, "swan-lake-preview7", "v2020-09-22", TOOL_VERSION, "Preview 7");

        // test bal dist remove <version>
        actualOutput = TestUtils.executeCommand(path + " dist remove slp7");
        Assert.assertTrue(actualOutput.contains("The active Ballerina distribution cannot be removed"));
        actualOutput = TestUtils.executeCommand(path + " dist remove " + SHORT_VERSION);
        Assert.assertTrue(actualOutput.contains("Distribution '" + SHORT_VERSION + "' successfully removed"));
        actualOutput = TestUtils.executeCommand(path + " dist use " + SHORT_VERSION);
        Assert.assertTrue(actualOutput.contains("Distribution '" + SHORT_VERSION + "' not found"));

        actualOutput = TestUtils.executeCommand(path + " dist update");
        Assert.assertTrue(actualOutput.contains("Fetching the latest patch distribution for 'ballerina-slp7' from the remote server..."));
        Assert.assertTrue(actualOutput.contains("Successfully set the latest patch distribution"));
        Assert.assertEquals(actualOutput.split("Downloading ")[1].split(" ")[0],
                actualOutput.split("Downloading ")[1].split(" ")[0]);

        // test bal dist remove -a
        actualOutput = TestUtils.executeCommand(path + " dist remove -a");
        Assert.assertTrue(actualOutput.contains("All non-active distributions are successfully removed"));
        actualOutput = TestUtils.executeCommand(path + " dist use 1.2.3");
        Assert.assertTrue(actualOutput.contains("Distribution '1.2.3' not found"));
    }

    @AfterClass
    public void cleanUp() throws IOException {
        TestUtils.cleanDistribution();
    }
}
