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
    String version = "1.1.2";

    @DataProvider(name = "getExecutors")
    public Object[][] dataProviderMethod() {
        Executor[][] result = new Executor[1][1];
        result[0][0] = TestUtils.getExecutor(version);
        return result;
    }

    @Test(dataProvider = "getExecutors")
    public void testSmoke(Executor executor) {
        executor.transferArtifacts();
        executor.install();
        Assert.assertEquals(executor.executeCommand("ballerina -v", false), TestUtils.getVersionOutput(version));
        executor.uninstall();
        executor.cleanArtifacts();
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
