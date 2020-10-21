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

jwt:InboundJwtAuthProvider jwtAuthProvider07_1 = new({
    issuer: "example1",
    audience: ["ballerina"],
    trustStoreConfig: {
        certificateAlias: "ballerina",
        trustStore: {
            path: TRUSTSTORE_PATH,
            password: "ballerina"
        }
    }
});
http:BearerAuthHandler jwtAuthHandler07_1 = new(jwtAuthProvider07_1);

listener http:Listener listener07_1 = new(20108, {
    auth: {
        authHandlers: [jwtAuthHandler07_1]
    },
    secureSocket: {
        keyStore: {
            path: KEYSTORE_PATH,
            password: "ballerina"
        }
    }
});

jwt:OutboundJwtAuthProvider jwtAuthProvider07_2 = new;
http:BearerAuthHandler jwtAuthHandler07_2 = new(jwtAuthProvider07_2);

http:Client nyseEP07 = new("https://localhost:20109", {
    auth: {
        authHandler: jwtAuthHandler07_2
    },
    secureSocket: {
       trustStore: {
           path: TRUSTSTORE_PATH,
           password: "ballerina"
       }
    }
});

@http:ServiceConfig { basePath: "/passthrough" }
service passthroughService07 on listener07_1 {

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/"
    }
    resource function passthrough(http:Caller caller, http:Request clientRequest) {
        var response = nyseEP07->get("/nyseStock/stocks", <@untainted> clientRequest);
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

jwt:InboundJwtAuthProvider jwtAuthProvider07_3 = new({
    issuer: "example1",
    audience: ["ballerina"],
    trustStoreConfig: {
        certificateAlias: "ballerina",
        trustStore: {
           path: TRUSTSTORE_PATH,
           password: "ballerina"
        }
    }
});
http:BearerAuthHandler jwtAuthHandler07_3 = new(jwtAuthProvider07_3);

listener http:Listener listener07_2 = new(20109, {
    auth: {
        authHandlers: [jwtAuthHandler07_3]
    },
    secureSocket: {
        keyStore: {
            path: KEYSTORE_PATH,
            password: "ballerina"
        }
    }
});

@http:ServiceConfig { basePath: "/nyseStock" }
service nyseStockQuote07 on listener07_2 {

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/stocks"
    }
    resource function stocks(http:Caller caller, http:Request clientRequest) {
        json payload = { "exchange": "nyse", "name": "IBM", "value": "077.50" };
        checkpanic caller->respond(payload);
    }
}
