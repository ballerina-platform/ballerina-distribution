/*
 * Copyright (c) 2020 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package org.ballerinalang.debugger.test;

import org.apache.commons.lang3.tuple.Pair;
import org.ballerinalang.debugger.test.utils.BallerinaTestDebugPoint;
import org.ballerinalang.debugger.test.utils.DebugUtils;
import org.ballerinalang.debugger.test.utils.TestUtils;
import org.ballerinalang.test.context.BallerinaTestException;
import org.eclipse.lsp4j.debug.StoppedEventArguments;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.nio.file.Paths;

import static org.ballerinalang.debugger.test.utils.DebugUtils.findFreePort;
import static org.ballerinalang.debugger.test.utils.TestUtils.*;

/**
 * Test class for service related debug scenarios.
 */
public class ServiceDebugTest extends DebugAdapterBaseTestCase {
    private String projectPath;

    @BeforeClass
    public void setup() {
        String testProjectName = "service-tests";
        projectPath = Paths.get(testProjectBaseDir.toString(), testProjectName).toString();

        String testModuleFileName = Paths.get("tests", "hello_service_test.bal").toString();
        testProjectPath = Paths.get(testProjectBaseDir.toString(), testProjectName).toString();
        testEntryFilePath = Paths.get(testProjectPath, testModuleFileName).toString();
    }

    @Test(enabled = false, description = "Test for service module debug engage")
    public void testModuleServiceDebugScenarios() throws BallerinaTestException {

        String testModuleFileName = "hello_service.bal";
        testEntryFilePath = Paths.get(testProjectPath, testModuleFileName).toString();
        String fileName1 = Paths.get("service-module", "hello_service.bal").toString();
        String filePath1 = Paths.get(testProjectPath, fileName1).toString();
        String fileName2 = "helloService.bal";
        String filePath2 = Paths.get(testProjectPath, fileName2).toString();
        int port = findFreePort();

        TestUtils.runDebuggeeProgram(projectPath, port);
        TestUtils.addBreakPoint(new BallerinaTestDebugPoint(filePath2, 11));
        TestUtils.addBreakPoint(new BallerinaTestDebugPoint(filePath1, 36));
        TestUtils.initDebugSession(null, port);

        // Test for service debug where service is inside a directory
        Pair<BallerinaTestDebugPoint, StoppedEventArguments> debugHitInfo = TestUtils.waitForDebugHit(20000);
        Assert.assertEquals(debugHitInfo.getLeft(), testBreakpoints.get(0));
        TestUtils.resumeProgram(debugHitInfo.getRight(), DebugResumeKind.NEXT_BREAKPOINT);

        // Test for service debug where service is in the root module
        debugHitInfo = TestUtils.waitForDebugHit(20000);
        Assert.assertEquals(debugHitInfo.getLeft(), testBreakpoints.get(1));
    }

    @Test(enabled = false, description = "Test for single bal file debug engage")
    public void testSingleBalFileServiceDebugScenarios() throws BallerinaTestException {

        String testSingleFileName = "hello_service.bal";
        testEntryFilePath = Paths.get(testSingleFileBaseDir.toString(), testSingleFileName).toString();
        TestUtils.addBreakPoint(new BallerinaTestDebugPoint(testEntryFilePath, 8));
        TestUtils.initDebugSession(DebugUtils.DebuggeeExecutionKind.TEST);

        Pair<BallerinaTestDebugPoint, StoppedEventArguments> debugHitInfo = TestUtils.waitForDebugHit(20000);
        Assert.assertEquals(debugHitInfo.getLeft(), testBreakpoints.get(0));
    }

    @AfterMethod(alwaysRun = true)
    public void cleanUp() {
        TestUtils.terminateDebugSession();
    }
}
