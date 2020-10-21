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

// The followings are the config patterns used for authorization scopes:
// * Pattern 1 - scopes: ["scope1"]
// * Pattern 2 - scopes: ["scope1", "scope2"]
// * Pattern 3 - scopes: [["scope1"]]
// * Pattern 4 - scopes: [["scope1"], ["scope3"]]
// * Pattern 5 - scopes: [["scope1", "scope2"], ["scope3", "scope4"]]

import ballerina/config;
import ballerina/http;
import ballerina/test;

http:Client clientEP10 = new("https://localhost:20010", {
    secureSocket: {
       trustStore: {
           path: config:getAsString("b7a.home") + "/bre/security/ballerinaTruststore.p12",
           password: "ballerina"
       }
    }
});

@test:Config {}
public function testValidUserForPattern1() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic Y2hhbmFrYToxMjM=");
    var response = clientEP10->get("/echo/test1", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

@test:Config {}
public function testValidUserForPattern2() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic Y2hhbmFrYToxMjM=");
    var response = clientEP10->get("/echo/test2", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

@test:Config {}
public function testValidUserForPattern3() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic Y2hhbmFrYToxMjM=");
    var response = clientEP10->get("/echo/test3", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

@test:Config {}
public function testValidUserForPattern4() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic Y2hhbmFrYToxMjM=");
    var response = clientEP10->get("/echo/test4", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

@test:Config {}
public function testValidUserForPattern5() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic Y2hhbmFrYToxMjM=");
    var response = clientEP10->get("/echo/test5", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

@test:Config {}
public function testInvalidUserForPattern1() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXN1cnU6eHh4");
    var response = clientEP10->get("/echo/test1", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

@test:Config {}
public function testInvalidUserForPattern2() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXN1cnU6eHh4");
    var response = clientEP10->get("/echo/test2", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

@test:Config {}
public function testInvalidUserForPattern3() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXN1cnU6eHh4");
    var response = clientEP10->get("/echo/test3", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

@test:Config {}
public function testInvalidUserForPattern4() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXN1cnU6eHh4");
    var response = clientEP10->get("/echo/test4", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

@test:Config {}
public function testInvalidUserForPattern5() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXN1cnU6eHh4");
    var response = clientEP10->get("/echo/test5", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}
