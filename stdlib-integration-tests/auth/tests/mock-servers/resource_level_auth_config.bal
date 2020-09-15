// Copyright (c) 2018 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

import ballerina/auth;
import ballerina/config;
import ballerina/http;

auth:InboundBasicAuthProvider basicAuthProvider03 = new;
http:BasicAuthHandler basicAuthHandler03 = new(basicAuthProvider03);

listener http:Listener listener03 = new(20004, {
    auth: {
        authHandlers: [basicAuthHandler03]
    },
    secureSocket: {
        keyStore: {
            path: config:getAsString("b7a.home") + "/bre/security/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
});

@http:ServiceConfig {
    basePath: "/echo"
}
service echo03 on listener03 {

    @http:ResourceConfig {
        methods: ["GET"],
        auth: {
            enabled: true,
            scopes: ["scope4"]
        }
    }
    resource function test(http:Caller caller, http:Request req) {
        checkpanic caller->respond();
    }
}
