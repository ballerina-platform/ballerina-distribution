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

http:Client clientEP1 = new("https://localhost:20001", {
    secureSocket: {
       trustStore: {
           path: config:getAsString("b7a.home") + "/bre/security/ballerinaTruststore.p12",
           password: "ballerina"
       }
    }
});

http:Client clientEP2 = new("https://localhost:20002", {
    secureSocket: {
       trustStore: {
           path: config:getAsString("b7a.home") + "/bre/security/ballerinaTruststore.p12",
           password: "ballerina"
       }
    }
});

http:Client clientEP3 = new("https://localhost:20003", {
    secureSocket: {
       trustStore: {
           path: config:getAsString("b7a.home") + "/bre/security/ballerinaTruststore.p12",
           password: "ballerina"
       }
    }
});

// Listener - valid scopes, service - valid scopes and resource - valid scopes
@test:Config {}
public function testValidScopesAtListener1() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP1->get("/echo1/test1", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Listener - valid scopes, service - valid scopes and resource - invalid scopes
@test:Config {}
public function testValidScopesAtListener2() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP1->get("/echo1/test2", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Listener - valid scopes, service - valid scopes and resource - scopes not given
@test:Config {}
public function testValidScopesAtListener3() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP1->get("/echo1/test3", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Listener - valid scopes, service - invalid scopes and resource - valid scopes
@test:Config {}
public function testValidScopesAtListener4() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP1->get("/echo2/test1", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Listener - valid scopes, service - invalid scopes and resource - invalid scopes
@test:Config {}
public function testValidScopesAtListener5() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP1->get("/echo2/test2", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Listener - valid scopes, service - invalid scopes and resource - scopes not given
@test:Config {}
public function testValidScopesAtListener6() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP1->get("/echo2/test3", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Listener - valid scopes, service - scopes not given and resource - valid scopes
@test:Config {}
public function testValidScopesAtListener7() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP1->get("/echo3/test1", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Listener - valid scopes, service - scopes not given and resource - invalid scopes
@test:Config {}
public function testValidScopesAtListener8() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP1->get("/echo3/test2", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Listener - valid scopes, service - scopes not given and resource - scopes not given
@test:Config {}
public function testValidScopesAtListener9() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP1->get("/echo3/test3", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Listener - invalid scopes, service - valid scopes and resource - valid scopes
@test:Config {}
public function testInvalidScopesAtListener1() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP2->get("/echo1/test1", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Listener - invalid scopes, service - valid scopes and resource - invalid scopes
@test:Config {}
public function testInvalidScopesAtListener2() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP2->get("/echo1/test2", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Listener - invalid scopes, service - valid scopes and resource - scopes not given
@test:Config {}
public function testInvalidScopesAtListener3() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP2->get("/echo1/test3", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Listener - invalid scopes, service - invalid scopes and resource - valid scopes
@test:Config {}
public function testInvalidScopesAtListener4() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP2->get("/echo2/test1", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Listener - invalid scopes, service - invalid scopes and resource - invalid scopes
@test:Config {}
public function testInvalidScopesAtListener5() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP2->get("/echo2/test2", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Listener - invalid scopes, service - invalid scopes and resource - scopes not given
@test:Config {}
public function testInvalidScopesAtListener6() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP2->get("/echo2/test3", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Listener - invalid scopes, service - scopes not given and resource - valid scopes
@test:Config {}
public function testInvalidScopesAtListener7() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP2->get("/echo3/test1", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Listener - invalid scopes, service - scopes not given and resource - invalid scopes
@test:Config {}
public function testInvalidScopesAtListener8() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP2->get("/echo3/test2", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Listener - invalid scopes, service - scopes not given and resource - scopes not given
@test:Config {}
public function testInvalidScopesAtListener9() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP2->get("/echo3/test3", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Listener - scopes not given, service - valid scopes and resource - valid scopes
@test:Config {}
public function testNotGivenScopesAtListener1() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP3->get("/echo1/test1", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Listener - scopes not given, service - valid scopes and resource - invalid scopes
@test:Config {}
public function testNotGivenScopesAtListener2() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP3->get("/echo1/test2", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Listener - scopes not given, service - valid scopes and resource - scopes not given
@test:Config {}
public function testNotGivenScopesAtListener3() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP3->get("/echo1/test3", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Listener - scopes not given, service - invalid scopes and resource - valid scopes
@test:Config {}
public function testNotGivenScopesAtListener4() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP3->get("/echo2/test1", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Listener - scopes not given, service - invalid scopes and resource - invalid scopes
@test:Config {}
public function testNotGivenScopesAtListener5() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP3->get("/echo2/test2", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Listener - scopes not given, service - invalid scopes and resource - scopes not given
@test:Config {}
public function testNotGivenScopesAtListener6() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP3->get("/echo2/test3", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Listener - scopes not given, service - scopes not given and resource - valid scopes
@test:Config {}
public function testNotGivenScopesAtListener7() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP3->get("/echo3/test1", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Listener - scopes not given, service - scopes not given and resource - invalid scopes
@test:Config {}
public function testNotGivenScopesAtListener8() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP3->get("/echo3/test2", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

// Listener - scopes not given, service - scopes not given and resource - scopes not given
@test:Config {}
public function testNotGivenScopesAtListener9() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP3->get("/echo3/test3", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}
