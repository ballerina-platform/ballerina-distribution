/*
 * Copyright (c) 2023 WSO2 LLC. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 LLC. licenses this file to you under the Apache License,
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
import org.eclipse.lsp4j.debug.StoppedEventArguments;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.nio.file.Path;

/**
 * Test cases to verify debugger engaging on source files inside the 'generated' directory (i.e. persist generation).
 *
 * @since 2201.6.1
 */
public class PersistDebugTest extends BaseTestCase {

    DebugTestRunner debugTestRunner;

    @BeforeClass
    public void setup() {
        // NOOP
    }

    @Test(description = "Test for debug engage with Ballerina sources generated in default module inside the " +
            "'generated' directory")
    public void testDebugEngageWithPersistDefaultModule() throws BallerinaTestException {
        String testProjectName = "persist-tests-1";
        String testModuleFileName = "main.bal";
        debugTestRunner = new DebugTestRunner(testProjectName, testModuleFileName, true);

        Path breakpointFilePath = debugTestRunner.testProjectPath.resolve("generated/persist_client.bal");
        debugTestRunner.addBreakPoint(new BallerinaTestDebugPoint(breakpointFilePath, 26));
        debugTestRunner.initDebugSession(DebugUtils.DebuggeeExecutionKind.RUN);

        // Test for debug engage
        Pair<BallerinaTestDebugPoint, StoppedEventArguments> debugHitInfo = debugTestRunner.waitForDebugHit(25000);
        Assert.assertEquals(debugHitInfo.getLeft(), debugTestRunner.testBreakpoints.get(0));
    }

    @Test(description = "Test for debug engage with Ballerina sources generated in other modules inside the " +
            "'generated' directory")
    public void testDebugEngageWithPersistOtherModules() throws BallerinaTestException {
        String testProjectName = "persist-tests-2";
        String testModuleFileName = "main.bal";
        debugTestRunner = new DebugTestRunner(testProjectName, testModuleFileName, true);

        Path breakpointFilePath = debugTestRunner.testProjectPath.resolve("generated/foo/persist_client.bal");
        debugTestRunner.addBreakPoint(new BallerinaTestDebugPoint(breakpointFilePath, 26));
        debugTestRunner.initDebugSession(DebugUtils.DebuggeeExecutionKind.RUN);

        // Test for debug engage
        Pair<BallerinaTestDebugPoint, StoppedEventArguments> debugHitInfo = debugTestRunner.waitForDebugHit(25000);
        Assert.assertEquals(debugHitInfo.getLeft(), debugTestRunner.testBreakpoints.get(0));
    }

    @AfterMethod(alwaysRun = true)
    public void cleanUp() {
        debugTestRunner.terminateDebugSession();
        debugTestRunner = null;
    }
}
