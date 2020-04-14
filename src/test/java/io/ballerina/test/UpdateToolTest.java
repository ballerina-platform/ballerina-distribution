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
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;


public class UpdateToolTest {
    String version = "1.2.0";
    String specVersion = "2020R1";
    String toolVersion = "0.8.5";

    String previousVersion = "1.1.0";
    String previousSpecVersion = "2019R3";
    String previousVersionsLatestPatch = "1.1.4";

    @DataProvider(name = "getExecutors")
    public Object[][] dataProviderMethod() {
        Executor[][] result = new Executor[1][1];
        result[0][0] = TestUtils.getExecutor(version);
        return result;
    }

    @Test(dataProvider = "getExecutors")
    public void testUpdateTool(Executor executor) {
        executor.transferArtifacts();
        executor.install();

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

        executor.uninstall();
        executor.cleanArtifacts();
    }
}
