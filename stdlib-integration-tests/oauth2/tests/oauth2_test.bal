// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

import ballerina/http;
import ballerina/regex;
import ballerina/test;

listener http:Listener oauth2Listener = new(25003, {
    secureSocket: {
        key: {
            path: "tests/resources/keystore/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
});

@http:ServiceConfig {
    auth: [
        {
            scopes: ["write", "update"],
            oauth2IntrospectionConfig: {
                url: "https://localhost:25999/oauth2/token/introspect",
                tokenTypeHint: "access_token",
                scopeKey: "scp",
                clientConfig: {
                    secureSocket: {
                       cert: {
                           path: "tests/resources/keystore/ballerinaTruststore.p12",
                           password: "ballerina"
                       }
                    }
                }
            }
        }
    ]
}
service /foo on oauth2Listener {
    resource function get bar() returns string {
        return "Hello World!";
    }
}

const string ACCESS_TOKEN = "2YotnFZFEjr1zCsicMWpAA";

@test:Config {}
public function testOAuth2Module() {
    http:Client clientEP = checkpanic new("https://localhost:25003", {
        secureSocket: {
           cert: {
               path: "tests/resources/keystore/ballerinaTruststore.p12",
               password: "ballerina"
           }
        },
        auth: {
            token: ACCESS_TOKEN
        }
    });
    var response = clientEP->get("/foo/bar");
    if (response is http:Response) {
        assertOK(response);
    } else {
        test:assertFail(msg = "Test Failed!");
    }
}

function assertOK(http:Response res) {
    test:assertEquals(res.statusCode, http:STATUS_OK, msg = "Response code mismatched");
}

// Mock OAuth2 authorization server implementation, which treats the APIs with successful responses.
listener http:Listener authorizationServer = new(25999, {
    secureSocket: {
        key: {
            path: "tests/resources/keystore/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
});
service /oauth2 on authorizationServer {
    resource function post token/introspect(http:Request request) returns json {
        string|http:ClientError payload = request.getTextPayload();
        if (payload is string) {
            string[] parts = regex:split(payload, "&");
            foreach string part in parts {
                if (part.indexOf("token=") is int) {
                    string token = regex:split(part, "=")[1];
                    if (token == ACCESS_TOKEN) {
                        json response = { "active": true, "exp": 3600, "scp": "read write" };
                        return response;
                    } else {
                        json response = { "active": false };
                        return response;
                    }
                }
            }
        }
    }
}
