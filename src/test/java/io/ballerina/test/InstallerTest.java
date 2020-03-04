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


public class InstallerTest {

    @DataProvider(name = "getExecutors")
    public Object[][] dataProviderMethod() {
        String version = "1.1.1";
        Executor[][] result = new Executor[1][1];
        result[0][0] = TestUtils.getExecutor(version);
        return result;
    }

    @Test(dataProvider = "getExecutors")
    public void testUpdateTool(Executor executor) {
        executor.transferArtifacts();
        executor.install();

        //Test installation
        Assert.assertEquals(executor.executeCommand("ballerina -v", false), TestUtils.getVersionOutput("1.1.1"));

        //Test `ballerina dist pull`
        executor.executeCommand("ballerina dist pull jballerina-1.1.0", true);

        Assert.assertEquals(executor.executeCommand("ballerina -v", false), TestUtils.getVersionOutput("1.1.0"));


        //Test `ballerina dist use`
        executor.executeCommand("ballerina dist use jballerina-1.1.1", true);

        Assert.assertEquals(executor.executeCommand("ballerina -v", false), TestUtils.getVersionOutput("1.1.1"));

        //Test `ballerina dist update`
        executor.executeCommand("ballerina dist use jballerina-1.1.0", true);
        executor.executeCommand("ballerina dist remove jballerina-1.1.1", true);
        executor.executeCommand("ballerina dist update", true);
        Assert.assertEquals(executor.executeCommand("ballerina -v", false), TestUtils.getVersionOutput("1.1.1"));

        //Try `ballerina dist remove`
        executor.executeCommand("ballerina dist remove jballerina-1.1.0", true);

        executor.uninstall();
        executor.cleanArtifacts();
    }
}
