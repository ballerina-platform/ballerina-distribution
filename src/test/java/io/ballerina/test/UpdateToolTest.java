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
    String version = System.getProperty("jballerina-version");
    String specVersion = System.getProperty("spec-version");
    String toolVersion = System.getProperty("latest-tool-version");

    String previousVersion = "1.2.0";
    String previousSpecVersion = "2020R1";
    String previousVersionsLatestPatch = "1.2.4";
    String previousToolVersion = "0.8.5";

    @DataProvider(name = "getExecutors")
    public Object[][] dataProviderMethod() {
        Executor[][] result = new Executor[1][1];
        result[0][0] = TestUtils.getExecutor(previousVersion);
        return result;
    }

    @Test(dataProvider = "getExecutors")
    public void testUpdateTool(Executor executor) {
        executor.transferArtifacts();
        executor.install();

        //Test installation
        TestUtils.testInstallation(executor, previousVersion, previousSpecVersion, previousToolVersion);

        //Test `ballerina update`
        executor.executeCommand("ballerina update", true);
        TestUtils.testInstallation(executor, previousVersion, previousSpecVersion, toolVersion);

        //Execute all ballerina dist commands once updated
        TestUtils.testDistCommands(executor, version, specVersion, toolVersion, previousVersion, previousSpecVersion,
                previousVersionsLatestPatch);

        executor.uninstall();
        executor.cleanArtifacts();
    }
}
