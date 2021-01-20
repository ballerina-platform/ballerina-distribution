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

import ballerina/http;
import ballerina/jwt;

jwt:InboundJwtAuthProvider jwtAuthProvider02 = new({
    issuer: "ballerina",
    audience: "ballerina",
    trustStoreConfig: {
        certificateAlias: "ballerina",
        trustStore: {
           path: TRUSTSTORE_PATH,
           password: "ballerina"
        }
    }
});

http:BearerAuthHandler jwtAuthHandler02 = new(jwtAuthProvider02);

listener http:Listener listener02 = new(20101, {
    auth: {
        authHandlers: [jwtAuthHandler02]
    },
    secureSocket: {
        keyStore: {
            path: KEYSTORE_PATH,
            password: "ballerina"
        }
    }
});

@http:ServiceConfig {
    basePath: "/echo",
    auth: {
        scopes: ["test-scope", "test-scp"]
    }
}
service echo02 on listener02 {

    resource function test(http:Caller caller, http:Request req) {
        checkpanic caller->respond();
    }
}
