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

package org.ballerina.devtools.debug;

import org.apache.commons.lang3.tuple.Pair;
import org.ballerinalang.debugger.test.utils.BallerinaTestDebugPoint;
import org.ballerinalang.debugger.test.utils.DebugTestRunner;
import org.ballerinalang.debugger.test.utils.DebugUtils;
import org.ballerinalang.test.context.BallerinaTestException;
import org.eclipse.lsp4j.debug.StackFrame;
import org.eclipse.lsp4j.debug.StoppedEventArguments;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * Test class for service related debug scenarios.
 */
public class ServiceDebugTest extends BaseTestCase {

    DebugTestRunner debugTestRunner;

    @BeforeClass
    public void setup() {
        String testProjectName = "service-tests";
        String testModuleFileName = Paths.get("tests", "hello_service_test.bal").toString();
        debugTestRunner = new DebugTestRunner(testProjectName, testModuleFileName, true);
    }

    @Test(description = "Test for service module debug engage")
    public void testModuleServiceDebugScenarios() throws BallerinaTestException {
        String fileName = "hello_service.bal";
        Path filePath = debugTestRunner.testProjectPath.resolve(fileName);

        debugTestRunner.addBreakPoint(new BallerinaTestDebugPoint(filePath, 20));
        debugTestRunner.addBreakPoint(new BallerinaTestDebugPoint(filePath, 24));
        debugTestRunner.initDebugSession(DebugUtils.DebuggeeExecutionKind.TEST);

        // test for debug hits in service level variables
        Pair<BallerinaTestDebugPoint, StoppedEventArguments> debugHitInfo = debugTestRunner.waitForDebugHit(30000);
        Assert.assertEquals(debugHitInfo.getLeft(), debugTestRunner.testBreakpoints.get(0));

        // Timeout Exception is expected, since the service get started once the VM is resumed and resource
        // function cannot have any debug hits until an HTTP request is received.
        debugTestRunner.resumeProgram(debugHitInfo.getRight(), DebugTestRunner.DebugResumeKind.NEXT_BREAKPOINT);
        try {
            debugTestRunner.waitForDebugHit(10000);
        } catch (BallerinaTestException e) {
            if (!e.getMessage().equals("Timeout expired waiting for the debug hit")) {
                throw e;
            }
        }
    }

    @Test(description = "Test for service call stack representation")
    public void serviceCallStackDebugTest() throws BallerinaTestException {
        String fileName = "hello_service.bal";
        Path filePath = debugTestRunner.testProjectPath.resolve(fileName);

        debugTestRunner.addBreakPoint(new BallerinaTestDebugPoint(filePath, 20));
        debugTestRunner.initDebugSession(DebugUtils.DebuggeeExecutionKind.TEST);

        // Test for service call stack representation
        Pair<BallerinaTestDebugPoint, StoppedEventArguments> debugHitInfo = debugTestRunner.waitForDebugHit(30000);
        StackFrame[] frames = debugTestRunner.fetchStackFrames(debugHitInfo.getRight());
        debugTestRunner.assertCallStack(frames[0], "service", 20, "hello_service.bal");
    }

    @Test(description = "Test for single bal file debug engage")
    public void testSingleBalFileServiceDebugScenarios() throws BallerinaTestException {
        String testProjectName = "";
        String testSingleFileName = "hello_service.bal";
        debugTestRunner = new DebugTestRunner(testProjectName, testSingleFileName, false);

        debugTestRunner.addBreakPoint(new BallerinaTestDebugPoint(debugTestRunner.testEntryFilePath, 24));
        debugTestRunner.initDebugSession(DebugUtils.DebuggeeExecutionKind.TEST);

        Pair<BallerinaTestDebugPoint, StoppedEventArguments> debugHitInfo = debugTestRunner.waitForDebugHit(30000);
        Assert.assertEquals(debugHitInfo.getLeft(), debugTestRunner.testBreakpoints.get(0));
    }

    @AfterMethod(alwaysRun = true)
    public void cleanUp() {
        debugTestRunner.terminateDebugSession();
    }
}
