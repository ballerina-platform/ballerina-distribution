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

http:Client clientEP0 = new("https://localhost:20000", {
    secureSocket: {
       trustStore: {
           path: config:getAsString("b7a.home") + "/bre/security/ballerinaTruststore.p12",
           password: "ballerina"
       }
    }
});

// Auth enabled resource, Auth enabled service test case with no auth headers
@test:Config {}
public function testNoAuthHeaders1() {
    http:Request req = new;
    var response = clientEP0->get("/echo1/test1", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth disabled resource, Auth enabled service test case with no auth headers
@test:Config {}
public function testNoAuthHeaders2() {
    http:Request req = new;
    var response = clientEP0->get("/echo1/test2", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth default resource, Auth enabled service test case with no auth headers
@test:Config {}
public function testNoAuthHeaders3() {
    http:Request req = new;
    var response = clientEP0->get("/echo1/test3", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth default resource, Auth enabled service test case with no auth headers
@test:Config {}
public function testNoAuthHeaders4() {
    http:Request req = new;
    var response = clientEP0->get("/echo2/test1", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth disabled resource, Auth disabled service test case with no auth headers
@test:Config {}
public function testNoAuthHeaders5() {
    http:Request req = new;
    var response = clientEP0->get("/echo2/test2", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth default resource, Auth disabled service test case with no auth headers
@test:Config {}
public function testNoAuthHeaders6() {
    http:Request req = new;
    var response = clientEP0->get("/echo2/test3", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth enabled resource, Auth default service test case with no auth headers
@test:Config {}
public function testNoAuthHeaders7() {
    http:Request req = new;
    var response = clientEP0->get("/echo3/test1", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth disabled resource, Auth default service test case with no auth headers
@test:Config {}
public function testNoAuthHeaders8() {
    http:Request req = new;
    var response = clientEP0->get("/echo3/test2", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth default resource, Auth default service test case with no auth headers
@test:Config {}
public function testNoAuthHeaders9() {
    http:Request req = new;
    var response = clientEP0->get("/echo3/test3", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth enabled resource, Auth enabled service test case with no auth headers
@test:Config {}
public function testValidAuthHeaders1() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP0->get("/echo1/test1", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth disabled resource, Auth enabled service test case with no auth headers
@test:Config {}
public function testValidAuthHeaders2() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP0->get("/echo1/test2", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth default resource, Auth enabled service test case with no auth headers
@test:Config {}
public function testValidAuthHeaders3() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP0->get("/echo1/test3", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth default resource, Auth enabled service test case with no auth headers
@test:Config {}
public function testValidAuthHeaders4() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP0->get("/echo2/test1", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

@test:Config {}
public function testValidAuthHeaders5() {
    // Auth disabled resource, Auth disabled service test case with no auth headers
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP0->get("/echo2/test2", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth default resource, Auth disabled service test case with no auth headers
@test:Config {}
public function testValidAuthHeaders6() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP0->get("/echo2/test3", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

@test:Config {}
public function testValidAuthHeaders7() {
    // Auth enabled resource, Auth default service test case with no auth headers
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP0->get("/echo3/test1", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth disabled resource, Auth default service test case with no auth headers
@test:Config {}
public function testValidAuthHeaders8() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP0->get("/echo3/test2", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth default resource, Auth default service test case with no auth headers
@test:Config {}
public function testValidAuthHeaders9() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic aXNoYXJhOmFiYw==");
    var response = clientEP0->get("/echo3/test3", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth enabled resource, Auth enabled service test case with no auth headers
@test:Config {}
public function testInvalidAuthHeaders1() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic dGVzdDp0ZXN0MTIz");
    var response = clientEP0->get("/echo1/test1", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth disabled resource, Auth enabled service test case with no auth headers
@test:Config {}
public function testInvalidAuthHeaders2() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic dGVzdDp0ZXN0MTIz");
    var response = clientEP0->get("/echo1/test2", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth default resource, Auth enabled service test case with no auth headers
@test:Config {}
public function testInvalidAuthHeaders3() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic dGVzdDp0ZXN0MTIz");
    var response = clientEP0->get("/echo1/test3", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth default resource, Auth enabled service test case with no auth headers
@test:Config {}
public function testInvalidAuthHeaders4() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic dGVzdDp0ZXN0MTIz");
    var response = clientEP0->get("/echo2/test1", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

@test:Config {}
public function testInvalidAuthHeaders5() {
    // Auth disabled resource, Auth disabled service test case with no auth headers
    http:Request req = new;
    req.setHeader("Authorization", "Basic dGVzdDp0ZXN0MTIz");
    var response = clientEP0->get("/echo2/test2", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth default resource, Auth disabled service test case with no auth headers
@test:Config {}
public function testInvalidAuthHeaders6() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic dGVzdDp0ZXN0MTIz");
    var response = clientEP0->get("/echo2/test3", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth enabled resource, Auth default service test case with no auth headers
@test:Config {}
public function testInvalidAuthHeaders7() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic dGVzdDp0ZXN0MTIz");
    var response = clientEP0->get("/echo3/test1", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth disabled resource, Auth default service test case with no auth headers
@test:Config {}
public function testInvalidAuthHeaders8() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic dGVzdDp0ZXN0MTIz");
    var response = clientEP0->get("/echo3/test2", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

// Auth default resource, Auth default service test case with no auth headers
@test:Config {}
public function testInvalidAuthHeaders9() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic dGVzdDp0ZXN0MTIz");
    var response = clientEP0->get("/echo3/test3", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else if (response is http:ClientError) {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}
