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

// token propagation is set to false by default
auth:InboundBasicAuthProvider basicAuthProvider05 = new;
http:BasicAuthHandler basicAuthHandler05 = new(basicAuthProvider05);

listener http:Listener listener05_1 = new(20104, {
    auth: {
        authHandlers: [basicAuthHandler05]
    },
    secureSocket: {
        keyStore: {
            path: KEYSTORE_PATH,
            password: "ballerina"
        }
    }
});

// client will not propagate JWT
http:Client nyseEP = new("https://localhost:20105", {
    secureSocket: {
        trustStore: {
            path: TRUSTSTORE_PATH,
            password: "ballerina"
        }
    }
});

@http:ServiceConfig { basePath: "/passthrough" }
service passthroughService05 on listener05_1 {

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/"
    }
    resource function passthrough(http:Caller caller, http:Request clientRequest) {
        var response = nyseEP->get("/nyseStock/stocks", <@untainted> clientRequest);
        if (response is http:Response) {
            checkpanic caller->respond(<@untainted> response);
        } else {
            http:Response resp = new;
            json errMsg = { "error": "error occurred while invoking the service: " + (<error>response).message() };
            resp.statusCode = 500;
            resp.setPayload(<@untainted> errMsg);
            checkpanic caller->respond(resp);
        }
    }
}

jwt:InboundJwtAuthProvider jwtAuthProvider05 = new({
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

http:BearerAuthHandler jwtAuthHandler05 = new(jwtAuthProvider05);

listener http:Listener listener05_2 = new(20105, {
    auth: {
        authHandlers: [jwtAuthHandler05]
    },
    secureSocket: {
        keyStore: {
            path: KEYSTORE_PATH,
            password: "ballerina"
        }
    }
});

@http:ServiceConfig { basePath: "/nyseStock" }
service nyseStockQuote05 on listener05_2 {

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/stocks"
    }
    resource function stocks(http:Caller caller, http:Request clientRequest) {
        json payload = { "exchange": "nyse", "name": "IBM", "value": "127.50" };
        checkpanic caller->respond(payload);
    }
}
