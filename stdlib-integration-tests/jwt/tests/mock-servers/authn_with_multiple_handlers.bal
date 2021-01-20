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

jwt:InboundJwtAuthProvider jwtAuthProvider01_1 = new({
    issuer: "example1",
    audience: "ballerina",
    trustStoreConfig: {
        certificateAlias: "ballerina",
        trustStore: {
            path: TRUSTSTORE_PATH,
            password: "ballerina"
        }
    }
});

jwt:InboundJwtAuthProvider jwtAuthProvider01_2 = new({
    issuer: "example2",
    audience: "ballerina",
    trustStoreConfig: {
        certificateAlias: "ballerina",
        trustStore: {
            path: TRUSTSTORE_PATH,
            password: "ballerina"
        }
    }
});


http:BearerAuthHandler jwtAuthHandler01_1 = new(jwtAuthProvider01_1);
http:BearerAuthHandler jwtAuthHandler01_2 = new(jwtAuthProvider01_2);

listener http:Listener listener01 = new(20100, {
    auth: {
        authHandlers: [jwtAuthHandler01_1, jwtAuthHandler01_2]
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
service echo01 on listener01 {

    resource function test(http:Caller caller, http:Request req) {
        checkpanic caller->respond();
    }
}
