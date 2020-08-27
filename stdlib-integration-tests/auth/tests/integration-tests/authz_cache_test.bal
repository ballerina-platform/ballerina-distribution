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

http:Client clientEP11 = new("https://localhost:20011", {
    secureSocket: {
       trustStore: {
           path: config:getAsString("b7a.home") + "/bre/security/ballerinaTruststore.p12",
           password: "ballerina"
       }
    }
});

// Authz cache test with success response
@test:Config {}
public function testAuthzCacheSuccess() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic YWxpY2U6MTIz");
    var response = clientEP11->get("/echo/test", req);
    if (response is http:Response) {
        assertOK(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }

    // The 2nd request is treated from the positive authz cache.
    req = new;
    req.setHeader("Authorization", "Basic YWxpY2U6MTIz");
    response = clientEP11->get("/echo/test", req);
    if (response is http:Response) {
        assertOK(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Authz cache test with forbidden response
@test:Config {}
public function testAuthzCacheForbidden() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic Y2hhbmFrYToxMjM=");
    var response = clientEP11->get("/echo/test", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }

    // The 2nd request is treated from the negative authz cache.
    req = new;
    req.setHeader("Authorization", "Basic Y2hhbmFrYToxMjM=");
    response = clientEP11->get("/echo/test", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Authz cache test with unauthorized response
@test:Config {}
public function testAuthzCacheUnauthorized() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic Ym9iOjEyMw==");
    var response = clientEP11->get("/echo/test", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }

    // The 2nd request is treated from the negative authz cache.
    req = new;
    req.setHeader("Authorization", "Basic Ym9iOjEyMw==");
    response = clientEP11->get("/echo/test", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}
