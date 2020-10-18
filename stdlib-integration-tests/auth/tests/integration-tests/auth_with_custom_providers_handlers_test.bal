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

http:Client clientEP7 = new("https://localhost:20007", {
    secureSocket: {
       trustStore: {
           path: config:getAsString("b7a.home") + "/bre/security/ballerinaTruststore.p12",
           password: "ballerina"
       }
    }
});

// Auth success with outbound custom auth provider initially generated token
@test:Config {}
public function testAuthSuccess1() {
    http:Request req = new;
    var response = clientEP7->get("/echo/test1", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is error) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Auth success with outbound custom auth provider generated token after inspection
@test:Config {}
public function testAuthSuccess2() {
    http:Request req = new;
    var response = clientEP7->get("/echo/test1", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is error) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Auth failure with outbound custom auth provider initially generated token and token after inspection
@test:Config {}
public function testAuthFailure() {
    http:Request req = new;
    var response = clientEP7->get("/echo/test3", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else if (response is error) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}
