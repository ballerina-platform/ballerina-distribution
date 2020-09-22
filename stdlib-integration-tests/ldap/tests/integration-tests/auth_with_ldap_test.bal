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

import ballerina/http;
import ballerina/test;

http:Client clientEndpoint = new("https://localhost:20300", {
    secureSocket: {
        trustStore: {
            path: TRUSTSTORE_PATH,
            password: "ballerina"
        }
    }
});

@test:Config {}
public function testAuthenticationFailure() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic ZXZlOnNlY3JldA==");
    var response = clientEndpoint->get("/orders/view", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

@test:Config {}
public function testAuthenticationSuccessAndAuthorizationFailure() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic amFuZWRvZTpqYW5lZG9lMTIz");
    var response = clientEndpoint->get("/orders/add", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

@test:Config {}
public function testAuthenticationSuccessAndAuthorizationSuccess() {
    http:Request req = new;
    req.setHeader("Authorization", "Basic amFuZWRvZTpqYW5lZG9lMTIz");
    var response = clientEndpoint->get("/orders/view", req);
    if (response is http:Response) {
        assertOK(response);
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}
