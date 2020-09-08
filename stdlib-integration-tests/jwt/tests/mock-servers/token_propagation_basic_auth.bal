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

import ballerina/auth;
import ballerina/http;
import ballerina/jwt;

auth:InboundBasicAuthProvider basicAuthProvider06_1 = new;
http:BasicAuthHandler basicAuthHandler06_1 = new(basicAuthProvider06_1);

listener http:Listener listener06_1 = new(20106, {
    auth: {
        authHandlers: [basicAuthHandler06_1]
    },
    secureSocket: {
        keyStore: {
            path: KEYSTORE_PATH,
            password: "ballerina"
        }
    }
});

jwt:OutboundJwtAuthProvider jwtAuthProvider06_2 = new({
    issuer: "ballerina",
    audience: ["ballerina"],
    keyStoreConfig: {
        keyAlias: "ballerina",
        keyPassword: "ballerina",
        keyStore: {
            path: KEYSTORE_PATH,
            password: "ballerina"
        }
    }
});
http:BearerAuthHandler jwtAuthHandler06_2 = new(jwtAuthProvider06_2);

http:Client nyseEP03 = new("https://localhost:20107", {
    auth: {
        authHandler: jwtAuthHandler06_2
    },
    secureSocket: {
       trustStore: {
           path: TRUSTSTORE_PATH,
           password: "ballerina"
       }
    }
});

@http:ServiceConfig { basePath: "/passthrough" }
service passthroughService06 on listener06_1 {

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/"
    }
    resource function passthrough(http:Caller caller, http:Request clientRequest) {
        var response = nyseEP03->get("/nyseStock/stocks", <@untainted> clientRequest);
        if (response is http:Response) {
            checkpanic caller->respond(response);
        } else {
            http:Response resp = new;
            json errMsg = { "error": "error occurred while invoking the service: " + response.message() };
            resp.statusCode = 500;
            resp.setPayload(errMsg);
            checkpanic caller->respond(resp);
        }
    }
}

jwt:InboundJwtAuthProvider jwtAuthProvider06_3 = new({
    issuer: "ballerina",
    audience: ["ballerina"],
    trustStoreConfig: {
        certificateAlias: "ballerina",
        trustStore: {
           path: TRUSTSTORE_PATH,
           password: "ballerina"
        }
    }
});
http:BearerAuthHandler jwtAuthHandler06_3 = new(jwtAuthProvider06_3);

listener http:Listener listener06_2 = new(20107, {
    auth: {
        authHandlers: [jwtAuthHandler06_3]
    },
    secureSocket: {
        keyStore: {
            path: KEYSTORE_PATH,
            password: "ballerina"
        }
    }
});

@http:ServiceConfig { basePath: "/nyseStock" }
service nyseStockQuote06 on listener06_2 {

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/stocks"
    }
    resource function stocks(http:Caller caller, http:Request clientRequest) {
        json payload = { "exchange": "nyse", "name": "IBM", "value": "127.50" };
        checkpanic caller->respond(payload);
    }
}
