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

    public static String getVersionOutput(String jBallerinaVersion, String specVersion, String toolVersion) {
        String [] versions = jBallerinaVersion.split("\\.");
        String ballerinaReference = versions[0].equals("1") && versions[1].equals("0")? "Ballerina" : "jBallerina";
        return ballerinaReference + " " + jBallerinaVersion + "\n" +
                "Language specification " + specVersion + "\n" +
                "Ballerina tool " + toolVersion + "\n";
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

    public static void testDistCommands(Executor executor, String version, String  specVersion, String toolVersion,
                                 String previousVersion, String previousSpecVersion,
                                 String previousVersionsLatestPatch) {
        //Test installation
        Assert.assertEquals(executor.executeCommand("ballerina -v", false),
                TestUtils.getVersionOutput(version, specVersion, toolVersion));

        //Test `ballerina dist pull`
        executor.executeCommand("ballerina dist pull jballerina-" + previousVersion, true);

        Assert.assertEquals(executor.executeCommand("ballerina -v", false),
                TestUtils.getVersionOutput(previousVersion, previousSpecVersion, toolVersion));


        //Test `ballerina dist use`
        executor.executeCommand("ballerina dist use jballerina-" + version, true);

        Assert.assertEquals(executor.executeCommand("ballerina -v", false),
                TestUtils.getVersionOutput(version, specVersion, toolVersion));

        //Test `ballerina dist update`
        executor.executeCommand("ballerina dist use jballerina-" + previousVersion, true);
        executor.executeCommand("ballerina dist remove jballerina-" + version, true);
        executor.executeCommand("ballerina dist update", true);
        Assert.assertEquals(executor.executeCommand("ballerina -v", false),
                TestUtils.getVersionOutput(previousVersionsLatestPatch, previousSpecVersion, toolVersion));

        //Try `ballerina dist remove`
        executor.executeCommand("ballerina dist remove jballerina-" + previousVersion, true);
    }


    /**
     * Test project and module creation.
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
