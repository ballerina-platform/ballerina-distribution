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


public class SmokeTest {

    @DataProvider(name = "getExecutors")
    public Object[][] dataProviderMethod() {
        String version = "1.1.1";
        Executor[][] result = new Executor[1][1];
        String provider = System.getenv("OS_TYPE");

        if (provider.equalsIgnoreCase("ubuntu")) {
            result[0][0] = new Ubuntu(version);
        } else if (provider.equalsIgnoreCase("windows")) {
            result[0][0] = new Windows(version);
        } else if (provider.equalsIgnoreCase("centos")) {
            result[0][0] = new CentOS(version);
        } else {
            throw new RuntimeException("OS_TYPE environment is not set");
        }
        return result;
    }

    @Test(dataProvider = "getExecutors")
    public void testSmoke(Executor executor) {
        executor.transferArtifacts();
        executor.install();
        Assert.assertEquals(executor.executeCommand("ballerina -v", false), TestUtils.getVersionOutput("1.1.2"));
        executor.uninstall();
        executor.cleanArtifacts();
    }
}
