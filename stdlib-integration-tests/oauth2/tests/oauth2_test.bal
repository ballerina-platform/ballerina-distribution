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

listener http:Listener oauth2Listener = new(25003, {
    secureSocket: {
        keyStore: {
            path: "./resources/keystore/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
});

@http:ServiceConfig {
    auth: [
        {
            scopes: ["write", "update"],
            oauth2IntrospectionConfig: {
                url: "https://localhost:25099/oauth2/token/introspect",
                tokenTypeHint: "access_token",
                scopeKey: "scp",
                clientConfig: {
                    secureSocket: {
                       trustStore: {
                           path: "./resources/keystore/ballerinaTruststore.p12",
                           password: "ballerina"
                       }
                    }
                }
            }
        }
    ]
}
service /foo on new authListener {
    resource function get bar() returns string {
        return "Hello World!";
    }
}

const string jwt = "eyJhbGciOiJSUzI1NiIsICJ0eXAiOiJKV1QiLCAia2lkIjoiTlRBeFptTXhORE15WkRnM01UVTFaR00wTXpFek9ESmhaV0k" +
                    "0TkRObFpEVTFPR0ZrTmpGaU1RIn0.eyJzdWIiOiJhZG1pbiIsICJpc3MiOiJ3c28yIiwgImV4cCI6MTkyNTk1NTcyNCwgIm" +
                    "p0aSI6IjEwMDA3ODIzNGJhMjMiLCAiYXVkIjpbImJhbGxlcmluYSJdLCAic2NwIjoid3JpdGUifQ.H99ufLvCLFA5i1gfCt" +
                    "klVdPrBvEl96aobNvtpEaCsO4v6_EgEZYz8Pg0B1Y7yJPbgpuAzXEg_CzowtfCTu3jUFf5FH_6M1fWGko5vpljtCb5Xknt_" +
                    "YPqvbk5fJbifKeXqbkCGfM9c0GS0uQO5ss8StquQcofxNgvImRV5eEGcDdybkKBNkbA-sJFHd1jEhb8rMdT0M0SZFLnhrPL" +
                    "8edbFZ-oa-ffLLls0vlEjUA7JiOSpnMbxRmT-ac6QjPxTQgNcndvIZVP2BHueQ1upyNorFKSMv8HZpATYHZjgnJQSpmt3Oa" +
                    "oFJ6pgzbFuniVNuqYghikCQIizqzQNfC7JUD8wA";

@test:Config {}
public function testAuthModule() {
    http:Client clientEP = new("https://localhost:25001", {
        secureSocket: {
           trustStore: {
               path: "./resources/keystore/ballerinaTruststore.p12",
               password: "ballerina"
           }
        }
        auth: {
            token: jwt
        }
    });
    var response = clientEP->get("/foo/bar");
    if (response is http:Response) {
        assertOK(response);
    } else {
        test:assertFail(msg = "Test Failed!");
    }
}


// Mock OAuth2 authorization server implementation, which treats the APIs with successful responses.
listener http:Listener authorizationServer = new(25099, {
    secureSocket: {
        keyStore: {
            path: "./resources/keystore/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
});
service /oauth2 on authorizationServer {
    resource function post token/introspect(http:Caller caller, http:Request request) {
        string|http:ClientError payload = request.getTextPayload();
        json response = ();
        if (payload is string) {
            string[] parts = regex:split(payload, "&");
            foreach string part in parts {
                if (part.indexOf("token=") is int) {
                    string token = regex:split(part, "=")[1];
                    if (token == ACCESS_TOKEN) {
                        response = { "active": true, "exp": 3600, "scp": "read write" };
                    } else {
                        response = { "active": false };
                    }
                    break;
                }
            }
        }
        http:Response res = new;
        res.setPayload(response);
        checkpanic caller->respond(res);
    }
}
