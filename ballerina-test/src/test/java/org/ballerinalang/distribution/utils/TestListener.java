/*
 * Copyright (c) 2020, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package org.ballerinalang.distribution.utils;

import org.testng.ITestResult;
import org.testng.TestListenerAdapter;

/**
 * Test reporter when running tests.
 */
public class TestListener extends TestListenerAdapter {
    public static final String ANSI_RESET = "\u001B[0m";
    public static final String ANSI_RED = "\u001B[31m";
    public static final String ANSI_GREEN = "\u001B[32m";
    public static final String ANSI_YELLOW = "\u001B[33m";
    
    @Override
    public void onTestFailure(ITestResult tr) {
        super.onTestFailure(tr);
        Object[] params = tr.getParameters();
        if (params.length > 0) {
            String dataValue = (String) params[0];
            TestUtils.OUT.println(ANSI_RED + "FAILED" + ANSI_RESET + " - " +
                                  tr.getTestClass().getRealClass().getSimpleName() + "." + tr.getName() + " with " +
                                  dataValue);
        } else {
            TestUtils.OUT.println(ANSI_RED + "FAILED" + ANSI_RESET + " - " +
                                  tr.getTestClass().getRealClass().getSimpleName() + "." + tr.getName());
        }
    }
    
    @Override
    public void onTestSkipped(ITestResult tr) {
        Object[] params = tr.getParameters();
        if (params.length > 0) {
            String dataValue = (String) params[0];
            TestUtils.OUT.println(ANSI_YELLOW + "SKIPPED" + ANSI_RESET + " - " +
                                  tr.getTestClass().getRealClass().getSimpleName() + "." + tr.getName() + " with " +
                                  dataValue);
        } else {
            TestUtils.OUT.println(ANSI_YELLOW + "SKIPPED" + ANSI_RESET + " - " +
                                  tr.getTestClass().getRealClass().getSimpleName() + "." + tr.getName());
        }
    }
    
    @Override
    public void onTestSuccess(ITestResult tr) {
        Object[] params = tr.getParameters();
        if (params.length > 0) {
            String dataValue = (String) params[0];
            TestUtils.OUT.println(ANSI_GREEN + "PASSED" + ANSI_RESET + " - " +
                                  tr.getTestClass().getRealClass().getSimpleName() + "." + tr.getName() + " with " +
                                  dataValue);
        } else {
            TestUtils.OUT.println(ANSI_GREEN + "PASSED" + ANSI_RESET + " - " +
                                  tr.getTestClass().getRealClass().getSimpleName() + "." + tr.getName());
        }
    }
    
    @Override
    public void beforeConfiguration(ITestResult tr) {
        super.onConfigurationSuccess(tr);
        if (tr.getMethod().isBeforeClassConfiguration()) {
            TestUtils.OUT.println("Starting " + tr.getTestClass().getRealClass().getSimpleName());
        } else if (tr.getMethod().isAfterClassConfiguration()) {
            TestUtils.OUT.println();
        }
    }
}
