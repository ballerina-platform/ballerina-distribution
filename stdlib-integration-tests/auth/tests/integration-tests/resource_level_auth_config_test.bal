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

// NOTE: All the tokens/credentials used in this test are dummy tokens/credentials and used only for testing purposes.

import ballerina/config;
import ballerina/http;
import ballerina/test;

http:Client clientEP4 = new("https://localhost:20004", {
    secureSocket: {
       trustStore: {
           path: config:getAsString("b7a.home") + "/bre/security/ballerinaTruststore.p12",
           password: "ballerina"
       }
    }
});

// Authn and authz success test case
@test:Config {}
public function testAuthSuccessWithResourceLevelConfigs() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXN1cnU6eHh4");
    var response = clientEP4->get("/echo/test", req);
    if (response is http:Response) {
        assertOK(response);
    } else {
        test:assertFail(msg = "Test Failed! " + (<http:ClientError>response).message());
    }
}

// Authn and authz success test case
@test:Config {}
public function testAuthzFailureWithResourceLevelConfigs() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP4->get("/echo/test", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else {
        test:assertFail(msg = "Test Failed! " + (<http:ClientError>response).message());
    }
}

// Authn and authz failure test case
@test:Config {}
public function testAuthFailureWithResourceLevelConfigs() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic dGVzdDp0ZXN0MTIz");
    var response = clientEP4->get("/echo/test", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + (<http:ClientError>response).message());
    }
}
