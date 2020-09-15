// Copyright (c) 2019 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

// NOTE: All the tokens/credentials used in this test are dummy tokens/credentials and used only for testing purposes.

import ballerina/auth;
import ballerina/http;
import ballerina/oauth2;

auth:OutboundBasicAuthProvider basicAuthProvider = new({
    username: "3MVG9YDQS5WtC11paU2WcQjBB3L5w4gz52uriT8ksZ3nUVjKvrfQMrU4uvZohTftxStwNEW4cfStBEGRxRL68",
    password: "9205371918321623741"
});
http:BasicAuthHandler basicAuthHandler = new(basicAuthProvider);

oauth2:IntrospectionServerConfig introspectionServerConfig = {
    url: "https://localhost:20299/oauth2/token/introspect",
    clientConfig: {
        auth: {
            authHandler: basicAuthHandler
        },
        secureSocket: {
           trustStore: {
               path: TRUSTSTORE_PATH,
               password: "ballerina"
           }
        }
    }
};
oauth2:InboundOAuth2Provider oauth2Provider21 = new(introspectionServerConfig);
http:BearerAuthHandler oauth2Handler21 = new(oauth2Provider21);

listener http:Listener listener21 = new(20200, {
    auth: {
        authHandlers: [oauth2Handler21]
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
service echo21 on listener21 {

    @http:ResourceConfig {
        methods: ["GET"]
    }
    resource function test(http:Caller caller, http:Request req) {
        checkpanic caller->respond();
    }
}
