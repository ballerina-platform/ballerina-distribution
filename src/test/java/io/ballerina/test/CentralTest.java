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


public class CentralTest {
    String version = "1.2.0";

    @DataProvider(name = "getExecutors")
    public Object[][] dataProviderMethod() {
        Executor[][] result = new Executor[1][1];
        result[0][0] = TestUtils.getExecutor(version);
        return result;
    }

    @Test(dataProvider = "getExecutors")
    public void testSmoke(Executor executor) {

        String expectedOutput = "wso2/twitter:0.9.26 [central.ballerina.io -> home repo]  100% " +
                "[================================================" +
                "=====================================================]" +
                " 13/13 KB (0:00:00 / 0:00:00) \n" +
                "wso2/twitter:0.9.26 pulled from central successfully\n";

        executor.transferArtifacts();
        executor.install();
        Assert.assertEquals(executor.executeCommand("ballerina pull wso2/twitter", false),
                expectedOutput);
        executor.uninstall();
        executor.cleanArtifacts();
    }
}
