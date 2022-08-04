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

package io.ballerina.installer.test;

import io.ballerina.test.Executor;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;


public class InstallerTest {
    String version = System.getProperty("BALLERINA_VERSION");
    String specVersion = System.getProperty("SPEC_VERSION");
    String toolVersion = System.getProperty("TOOL_VERSION");

    @DataProvider(name = "getExecutors")
    public Object[][] dataProviderMethod() {
        Executor[][] result = new Executor[1][1];
        result[0][0] = TestUtils.getExecutor(version);
        return result;
    }

    @Test(dataProvider = "getExecutors")
    public void testSmoke(Executor executor) {
        if (!System.getProperty("BALLERINA_INSTALLED").equals("true")) {
            executor.transferArtifacts();
            executor.install();
        }

        TestUtils.testInstallation(executor, version, specVersion, toolVersion, System.getProperty("VERSION_DISPLAY_TEXT"));

        if (!System.getProperty("BALLERINA_INSTALLED").equals("true")) {
            executor.uninstall();
            executor.cleanArtifacts();
        }
    }
}
