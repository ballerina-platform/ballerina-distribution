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

jwt:InboundJwtAuthProvider jwtAuthProvider03 = new({
    issuer:"ballerina",
    audience: "ballerina.io",
    trustStoreConfig: {
        certificateAlias: "cert",
        trustStore: {
            path: EXPIRED_TRUSTSTORE_PATH,
            password: "ballerina"
        }
    }
});

http:BearerAuthHandler jwtAuthHandler03 = new(jwtAuthProvider03);

listener http:Listener listener03 = new(20102, {
    auth: {
        authHandlers: [jwtAuthHandler03]
    },
    secureSocket: {
        keyStore: {
            path: KEYSTORE_PATH,
            password: "ballerina"
        }
    }
});

@http:ServiceConfig {
    basePath: "/echo"
}
service echo03 on listener03 {

    resource function test(http:Caller caller, http:Request req) {
        checkpanic caller->respond();
    }
}
