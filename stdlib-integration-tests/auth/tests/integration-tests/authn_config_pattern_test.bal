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

// The followings are the config patterns used for authentication handlers:
// * Pattern 1 - authHandlers: [basicAuthHandler1]
// * Pattern 2 - authHandlers: [basicAuthHandler1, basicAuthHandler2]
// * Pattern 3 - authHandlers: [[basicAuthHandler1]]
// * Pattern 4 - authHandlers: [[basicAuthHandler1], [basicAuthHandler3]]
// * Pattern 5 - authHandlers: [[basicAuthHandler1, basicAuthHandler2], [basicAuthHandler3, basicAuthHandler4]]

import ballerina/config;
import ballerina/http;
import ballerina/test;

http:Client clientEP9 = new("https://localhost:20009", {
    secureSocket: {
       trustStore: {
           path: config:getAsString("b7a.home") + "/bre/security/ballerinaTruststore.p12",
           password: "ballerina"
       }
    }
});

// Test pattern 1 with user group1
@test:Config {}
public function testUserGroup1ForPattern1() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic Y2hhbmFrYToxMjM=");
    var response = clientEP9->get("/echo/test1", req);
    if (response is http:Response) {
        assertOK(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Test pattern 2 with user group1
@test:Config {}
public function testUserGroup1ForPattern2() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic Y2hhbmFrYToxMjM=");
    var response = clientEP9->get("/echo/test2", req);
    if (response is http:Response) {
        assertOK(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Test pattern 3 with user group1
@test:Config {}
public function testUserGroup1ForPattern3() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic Y2hhbmFrYToxMjM=");
    var response = clientEP9->get("/echo/test3", req);
    if (response is http:Response) {
        assertOK(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Test pattern 4 with user group1
@test:Config {}
public function testUserGroup1ForPattern4() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic Y2hhbmFrYToxMjM=");
    var response = clientEP9->get("/echo/test4", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Test pattern 5 with user group1
@test:Config {}
public function testUserGroup1ForPattern5() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic Y2hhbmFrYToxMjM=");
    var response = clientEP9->get("/echo/test5", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Test pattern 1 with user group2
@test:Config {}
public function testUserGroup2ForPattern1() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic bGFrbWFsOjQ1Ng==");
    var response = clientEP9->get("/echo/test1", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Test pattern 2 with user group2
@test:Config {}
public function testUserGroup2ForPattern2() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic bGFrbWFsOjQ1Ng==");
    var response = clientEP9->get("/echo/test2", req);
    if (response is http:Response) {
        assertOK(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Test pattern 3 with user group2
@test:Config {}
public function testUserGroup2ForPattern3() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic bGFrbWFsOjQ1Ng==");
    var response = clientEP9->get("/echo/test3", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Test pattern 4 with user group2
@test:Config {}
public function testUserGroup2ForPattern4() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic bGFrbWFsOjQ1Ng==");
    var response = clientEP9->get("/echo/test4", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Test pattern 5 with user group2
@test:Config {}
public function testUserGroup2ForPattern5() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic bGFrbWFsOjQ1Ng==");
    var response = clientEP9->get("/echo/test5", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Test pattern 1 with user group3
@test:Config {}
public function testUserGroup3ForPattern1() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic YWxpY2U6Nzg5");
    var response = clientEP9->get("/echo/test1", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Test pattern 2 with user group3
@test:Config {}
public function testUserGroup3ForPattern2() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic YWxpY2U6Nzg5");
    var response = clientEP9->get("/echo/test2", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Test pattern 3 with user group3
@test:Config {}
public function testUserGroup3ForPattern3() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic YWxpY2U6Nzg5");
    var response = clientEP9->get("/echo/test3", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Test pattern 4 with user group3
@test:Config {}
public function testUserGroup3ForPattern4() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic YWxpY2U6Nzg5");
    var response = clientEP9->get("/echo/test4", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Test pattern 5 with user group3
@test:Config {}
public function testUserGroup3ForPattern5() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic YWxpY2U6Nzg5");
    var response = clientEP9->get("/echo/test5", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Test pattern 1 with user group4
@test:Config {}
public function testUserGroup4ForPattern1() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic Ym9iOjE1MA==");
    var response = clientEP9->get("/echo/test1", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Test pattern 2 with user group4
@test:Config {}
public function testUserGroup4ForPattern2() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic Ym9iOjE1MA==");
    var response = clientEP9->get("/echo/test2", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Test pattern 3 with user group4
@test:Config {}
public function testUserGroup4ForPattern3() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic Ym9iOjE1MA==");
    var response = clientEP9->get("/echo/test3", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Test pattern 4 with user group4
@test:Config {}
public function testUserGroup4ForPattern4() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic Ym9iOjE1MA==");
    var response = clientEP9->get("/echo/test4", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Test pattern 5 with user group4
@test:Config {}
public function testUserGroup4ForPattern5() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic Ym9iOjE1MA==");
    var response = clientEP9->get("/echo/test5", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}
