/*
 * Copyright (c) 2022 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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
import org.eclipse.lsp4j.debug.StoppedEventArguments;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.nio.file.Paths;

/**
 * Test class for expression evaluation related scenarios.
 */
public class ExpressionEvaluationTest extends BaseTestCase {

    private DebugTestRunner debugTestRunner;
    private StoppedEventArguments context;

    @BeforeClass
    public void setup() throws BallerinaTestException {
        prepareForEvaluation();
    }

    @Test(description = "Test Ballerina standard library related remote method call evaluations")
    public void testRemoteCallEvaluation() throws BallerinaTestException {
        debugTestRunner.assertExpression(context, "httpClient->get(\"/args/ballerina-platform/repos\");", "Not Found",
                "error");
    }

    @Test(description = "Test Ballerina standard library related object methods evaluations")
    public void testObjectMethodEvaluation() throws BallerinaTestException {
        debugTestRunner.assertExpression(context, "response.getContentType()", "\"application/json; charset=utf-8\"",
                "string");
        debugTestRunner.assertExpression(context, "response.getTextPayload()", "\"{\"message\":\"Not Found\"," +
                "\"documentation_url\":\"https://docs.github.com/rest\"}\"", "string");
    }

    @AfterClass(alwaysRun = true)
    public void cleanUp() {
        debugTestRunner.terminateDebugSession();
        this.context = null;
    }

    protected void prepareForEvaluation() throws BallerinaTestException {
        String testProjectName = "evaluation-tests";
        String testModuleFileName = Paths.get("main.bal").toString();
        debugTestRunner = new DebugTestRunner(testProjectName, testModuleFileName, true);

        debugTestRunner.addBreakPoint(new BallerinaTestDebugPoint(debugTestRunner.testEntryFilePath, 24));
        debugTestRunner.initDebugSession(DebugUtils.DebuggeeExecutionKind.RUN);
        Pair<BallerinaTestDebugPoint, StoppedEventArguments> debugHitInfo = debugTestRunner.waitForDebugHit(25000);
        this.context = debugHitInfo.getRight();
    }
}
