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

// Only `JwtTrustStoreConfig`
jwt:InboundJwtAuthProvider jwtAuthProvider10_1 = new({
    issuer: "ballerina",
    audience: "vEwzbcasJVQm1jVYHUHCjhxZ4tYa",
    trustStoreConfig: {
        certificateAlias: "ballerina",
        trustStore: {
            path: TRUSTSTORE_PATH,
            password: "ballerina"
        }
    }
});

http:BearerAuthHandler jwtAuthHandler10_1 = new(jwtAuthProvider10_1);

listener http:Listener listener10_1 = new(20114, {
    auth: {
        authHandlers: [jwtAuthHandler10_1]
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
service echo10_1 on listener10_1 {

    resource function test(http:Caller caller, http:Request req) {
        checkpanic caller->respond();
    }
}

// Only `JwksConfig`
jwt:InboundJwtAuthProvider jwtAuthProvider10_2 = new({
    issuer: "ballerina",
    audience: "vEwzbcasJVQm1jVYHUHCjhxZ4tYa",
    jwksConfig: {
        url: "https://localhost:20199/oauth2/jwks",
        clientConfig: {
            secureSocket: {
                trustStore: {
                    path: TRUSTSTORE_PATH,
                    password: "ballerina"
                }
            }
        }
    }
});

http:BearerAuthHandler jwtAuthHandler10_2 = new(jwtAuthProvider10_2);

listener http:Listener listener10_2 = new(20115, {
    auth: {
        authHandlers: [jwtAuthHandler10_2]
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
service echo10_2 on listener10_2 {

    resource function test(http:Caller caller, http:Request req) {
        checkpanic caller->respond();
    }
}

// Both `JwtTrustStoreConfig` and `JwksConfig`
jwt:InboundJwtAuthProvider jwtAuthProvider10_3 = new({
    issuer: "ballerina",
    audience: "vEwzbcasJVQm1jVYHUHCjhxZ4tYa",
    jwksConfig: {
        url: "https://localhost:20199/oauth2/jwks",
        clientConfig: {
            secureSocket: {
                trustStore: {
                    path: TRUSTSTORE_PATH,
                    password: "ballerina"
                }
            }
        }
    },
    trustStoreConfig: {
        certificateAlias: "ballerina",
        trustStore: {
            path: TRUSTSTORE_PATH,
            password: "ballerina"
        }
    }
});

http:BearerAuthHandler jwtAuthHandler10_3 = new(jwtAuthProvider10_3);

listener http:Listener listener10_3 = new(20116, {
    auth: {
        authHandlers: [jwtAuthHandler10_3]
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
service echo10_3 on listener10_3 {

    resource function test(http:Caller caller, http:Request req) {
        checkpanic caller->respond();
    }
}

// No `JwtTrustStoreConfig` or `JwksConfig`
jwt:InboundJwtAuthProvider jwtAuthProvider10_4 = new({
    issuer: "ballerina",
    audience: "vEwzbcasJVQm1jVYHUHCjhxZ4tYa"
});

http:BearerAuthHandler jwtAuthHandler10_4 = new(jwtAuthProvider10_4);

listener http:Listener listener10_4 = new(20117, {
    auth: {
        authHandlers: [jwtAuthHandler10_4]
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
service echo10_4 on listener10_4 {

    resource function test(http:Caller caller, http:Request req) {
        checkpanic caller->respond();
    }
}
