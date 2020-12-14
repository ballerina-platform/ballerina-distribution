// Copyright (c) 2020 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/test;
import ballerina/io;
import ballerina/http;

# Before Suite Function
@test:BeforeSuite
function beforeSuiteServiceFunc () {
    io:println("This will test if a service start during testing");
}

# Test function
@test:Config{}
function testServiceFunction ()  {
    http:Client httpClient = new("http://localhost:9191");
    var response = httpClient->get("/sayHello");
    if (response is http:Response) {
        test:assertEquals(response.getTextPayload(), "Hello, World!", "Service involation test");
    } else {
        test:assertFail(response.toString());
    }
}

# After Suite Function
@test:AfterSuite {}
function afterSuiteServiceFunc () {
    io:println("Service should stop after this.");
}
