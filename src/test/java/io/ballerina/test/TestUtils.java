/*
 * Copyright (c) 2020, WSO2 Inc. (http://wso2.com) All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package io.ballerina.test;


import org.testng.Assert;

import java.util.Locale;

public class TestUtils {
    private static final String OS = System.getProperty("os.name").toLowerCase(Locale.getDefault());
    private static final String SWAN_LAKE_KEYWORD = "swan-lake";


    public static String getVersionOutput(String jBallerinaVersion, String specVersion, String toolVersion) {
        String toolText = toolVersion.equals("0.8.5") || toolVersion.equals("0.8.0") ?
                "Ballerina tool" : "Update Tool";
        if (jBallerinaVersion.contains(TestUtils.SWAN_LAKE_KEYWORD)) {
            //TODO : Need to revisit and improve
            return "Ballerina Swan Lake Preview 1\n" + "Language specification " + specVersion + "\n" +
                    toolText + " " + toolVersion + "\n";
        }

        String ballerinaReference = isSupportedRelease(jBallerinaVersion) ? "jBallerina" : "Ballerina";
        return ballerinaReference + " " + jBallerinaVersion + "\n" +
                "Language specification " + specVersion + "\n" +
                toolText + " " + toolVersion + "\n";
    }

    public static Executor getExecutor(String version) {
        Executor executor;
        if (OS.contains("win")) {
            executor = new Windows(version);
        } else if (OS.contains("mac")) {
            executor = new MacOS(version);
        } else {
            String provider = System.getenv("OS_TYPE");
            if (provider != null && provider.equalsIgnoreCase("centos")) {
                executor = new CentOS(version);
            } else {
                executor = new Ubuntu(version);
            }
        }
        return executor;
    }

    public static void testDistCommands(Executor executor, String version, String specVersion, String toolVersion,
                                        String previousVersion, String previousSpecVersion,
                                        String previousVersionsLatestPatch) {
        //Test installation
        TestUtils.testInstallation(executor, version, specVersion, toolVersion);

        //Test `ballerina dist list`
        String actualOutput = executor.executeCommand("ballerina dist list", false);
        Assert.assertTrue(actualOutput.contains("jballerina-1.0.0"));
        Assert.assertTrue(actualOutput.contains("jballerina-1.1.0"));
        Assert.assertTrue(actualOutput.contains("jballerina-1.2.0"));

        //Test `ballerina dist pull`
        executor.executeCommand("ballerina dist pull jballerina-" + previousVersion, true);

        TestUtils.testInstallation(executor, previousVersion, previousSpecVersion, toolVersion);

        //Test Update notification message
        if (isSupportedRelease(previousVersion)) {
            String expectedOutput = "A new version of Ballerina is available: jballerina-" + previousVersionsLatestPatch
                    + "\nUse 'ballerina dist pull jballerina-" + previousVersionsLatestPatch
                    + "' to download and use the distribution\n\n";
            Assert.assertEquals(executor.executeCommand("ballerina build", false), expectedOutput);
        }

        //Test `ballerina dist use`
        executor.executeCommand("ballerina dist use jballerina-" + version, true);

        //Verify the the installation
        TestUtils.testInstallation(executor, version, specVersion, toolVersion);

        //Test `ballerina dist update`
        executor.executeCommand("ballerina dist use jballerina-" + previousVersion, true);
        executor.executeCommand("ballerina dist remove jballerina-" + version, true);
        executor.executeCommand("ballerina dist update", true);
        TestUtils.testInstallation(executor, previousVersionsLatestPatch, previousSpecVersion, toolVersion);

        //Try `ballerina dist remove`
        executor.executeCommand("ballerina dist remove jballerina-" + previousVersion, true);
    }

    /**
     * Execute smoke testing to verify installation.
     *
     * @param executor    Executor for relevant operating system
     * @param version     Installed jBallerina version
     * @param specVersion Installed language specification
     * @param toolVersion Installed tool version
     */
    public static void testInstallation(Executor executor, String version, String specVersion, String toolVersion) {
        Assert.assertEquals(executor.executeCommand("ballerina -v", false),
                TestUtils.getVersionOutput(version, specVersion, toolVersion));
    }

    /**
     * To check whether installation is a 1.0.x release.
     *
     * @return returns is a 1.0.x release
     */
    public static boolean isSupportedRelease(String version) {
        if (version.contains(TestUtils.SWAN_LAKE_KEYWORD)) {
            return true;
        }

        String[] versions = version.split("\\.");
        return !(versions[0].equals("1") && versions[1].equals("0"));
    }


    /**
     * Test project and module creation.
     *
     * @param executor Executor for relevant operating system
     */
    public void testProject(Executor executor) {
        String expectedOutput = "Created new Ballerina project at project1\n" +
                "\n" +
                "Next:\n" +
                "    Move into the project directory and use `ballerina add <module-name>` to\n" +
                "    add a new Ballerina module.\n";
        Assert.assertEquals(executor.executeCommand("ballerina new project1", false), expectedOutput);

        executor.executeCommand("cd project1", false);
        expectedOutput = "Added new ballerina module at 'src/module1'\n";
        Assert.assertEquals(executor.executeCommand("ballerina add module1'", false), expectedOutput);
    }
}
