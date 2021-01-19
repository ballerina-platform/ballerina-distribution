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

listener http:Listener authListener = new(25001, {
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
            fileUserStoreConfig: {
                tableName: "b7a.users",
                scopeKey: "scopes"
            }
        }
    ]
}
service /foo on new authListener {
    resource function get bar() returns string {
        return "Hello World!";
    }
}

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
            username: "alice",
            password: "123"
        }
    });
    var response = clientEP->get("/foo/bar");
    if (response is http:Response) {
        assertOK(response);
    } else {
        test:assertFail(msg = "Test Failed!");
    }
}
