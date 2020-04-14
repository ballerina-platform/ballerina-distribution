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
        return "jBallerina " + jBallerinaVersion + "\n" +
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

    public static void distTests(Executor executor, String version, String  specVersion, String toolVersion,
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
}
