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

// NOTE: All the tokens/credentials used in this test are dummy tokens/credentials and used only for testing purposes.

import ballerina/http;
import ballerina/oauth2;
import ballerina/test;

@test:Config {}
public function testClientCredentialsGrantType1() {
    // Test the client credentials grant type with valid credentials
    oauth2:OutboundOAuth2Provider oauth2Provider1 = new({
        tokenUrl: "https://localhost:20299/oauth2/token/authorize/header",
        clientId: "3MVG9YDQS5WtC11paU2WcQjBB3L5w4gz52uriT8ksZ3nUVjKvrfQMrU4uvZohTftxStwNEW4cfStBEGRxRL68",
        clientSecret: "9205371918321623741",
        scopes: ["token-scope1", "token-scope2"],
        clientConfig: {
            secureSocket: {
               trustStore: {
                   path: TRUSTSTORE_PATH,
                   password: "ballerina"
               }
            }
        }
    });
    http:BearerAuthHandler oauth2Handler1 = new(oauth2Provider1);
    http:Client clientEP1 = new("https://localhost:20298", {
        auth: {
            authHandler: oauth2Handler1
        },
        secureSocket: {
           trustStore: {
               path: TRUSTSTORE_PATH,
               password: "ballerina"
           }
        }
    });

    http:Request req = new;
    var response = clientEP1->get("/foo/bar", req);
    if (response is http:Response) {
        assertContains(response, "access_granted");
    } else {
        test:assertFail(msg = "Test Failed! " + (<http:ClientError>response).message());
    }
}

@test:Config {}
public function testClientCredentialsGrantType2() {
    // Test the client credentials grant type with invalid client credentials
    oauth2:OutboundOAuth2Provider oauth2Provider2 = new({
        tokenUrl: "https://localhost:20299/oauth2/token/authorize/header",
        clientId: "invalid_client_id",
        clientSecret: "invalid_client_secret",
        scopes: ["token-scope1", "token-scope2"],
        clientConfig: {
            secureSocket: {
               trustStore: {
                   path: TRUSTSTORE_PATH,
                   password: "ballerina"
               }
            }
        }
    });
    http:BearerAuthHandler oauth2Handler2 = new(oauth2Provider2);
    http:Client clientEP2 = new("https://localhost:20298", {
        auth: {
            authHandler: oauth2Handler2
        },
        secureSocket: {
           trustStore: {
               path: TRUSTSTORE_PATH,
               password: "ballerina"
           }
        }
    });

    http:Request req = new;
    var response = clientEP2->get("/foo/bar", req, string);
    if (response is http:ClientError) {
        assertContains(response, "invalid_client");
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response);
    }
}

@test:Config {}
public function testClientCredentialsGrantType3() {
    // Test the client credentials grant type with a post-body bearer and valid credentials
    oauth2:OutboundOAuth2Provider oauth2Provider3 = new({
        credentialBearer: http:POST_BODY_BEARER,
        tokenUrl: "https://localhost:20299/oauth2/token/authorize/body",
        clientId: "3MVG9YDQS5WtC11paU2WcQjBB3L5w4gz52uriT8ksZ3nUVjKvrfQMrU4uvZohTftxStwNEW4cfStBEGRxRL68",
        clientSecret: "9205371918321623741",
        scopes: ["token-scope1", "token-scope2"],
        clientConfig: {
            secureSocket: {
               trustStore: {
                   path: TRUSTSTORE_PATH,
                   password: "ballerina"
               }
            }
        }
    });
    http:BearerAuthHandler oauth2Handler3 = new(oauth2Provider3);
    http:Client clientEP3 = new("https://localhost:20298", {
        auth: {
            authHandler: oauth2Handler3
        },
        secureSocket: {
           trustStore: {
               path: TRUSTSTORE_PATH,
               password: "ballerina"
           }
        }
    });

    http:Request req = new;
    var response = clientEP3->get("/foo/bar", req);
    if (response is http:Response) {
        assertContains(response, "access_granted");
    } else {
        test:assertFail(msg = "Test Failed! " + (<http:ClientError>response).message());
    }
}

@test:Config {}
public function testClientCredentialsGrantType4() {
    // Test the client credentials grant type with a post-body bearer and invalid credentials
    oauth2:OutboundOAuth2Provider oauth2Provider4 = new({
        credentialBearer: http:POST_BODY_BEARER,
        tokenUrl: "https://localhost:20299/oauth2/token/authorize/body",
        clientId: "invalid_client_id",
        clientSecret: "invalid_client_secret",
        scopes: ["token-scope1", "token-scope2"],
        clientConfig: {
            secureSocket: {
               trustStore: {
                   path: TRUSTSTORE_PATH,
                   password: "ballerina"
               }
            }
        }
    });
    http:BearerAuthHandler oauth2Handler4 = new(oauth2Provider4);
    http:Client clientEP4 = new("https://localhost:20298", {
        auth: {
            authHandler: oauth2Handler4
        },
        secureSocket: {
           trustStore: {
               path: TRUSTSTORE_PATH,
               password: "ballerina"
           }
        }
    });

    http:Request req = new;
    var response = clientEP4->get("/foo/bar", req, string);
    if (response is http:ClientError) {
        assertContains(response, "invalid_client");
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response);
    }
}

@test:Config {}
public function testPasswordGrantType1() {
    // Test the password grant type with valid credentials
    oauth2:OutboundOAuth2Provider oauth2Provider5 = new({
        tokenUrl: "https://localhost:20299/oauth2/token/authorize/header",
        username: "johndoe",
        password: "A3ddj3w",
        clientId: "3MVG9YDQS5WtC11paU2WcQjBB3L5w4gz52uriT8ksZ3nUVjKvrfQMrU4uvZohTftxStwNEW4cfStBEGRxRL68",
        clientSecret: "9205371918321623741",
        scopes: ["token-scope1", "token-scope2"],
        clientConfig: {
            secureSocket: {
               trustStore: {
                   path: TRUSTSTORE_PATH,
                   password: "ballerina"
               }
            }
        }
    });
    http:BearerAuthHandler oauth2Handler5 = new(oauth2Provider5);
    http:Client clientEP5 = new("https://localhost:20298", {
        auth: {
            authHandler: oauth2Handler5
        },
        secureSocket: {
           trustStore: {
               path: TRUSTSTORE_PATH,
               password: "ballerina"
           }
        }
    });

    http:Request req = new;
    var response = clientEP5->get("/foo/bar", req);
    if (response is http:Response) {
        assertContains(response, "access_granted");
    } else {
        test:assertFail(msg = "Test Failed! " + (<http:ClientError>response).message());
    }
}

@test:Config {}
public function testPasswordGrantType2() {
    // Test the password grant type with valid credentials and a valid refresh config
    oauth2:OutboundOAuth2Provider oauth2Provider6 = new({
        tokenUrl: "https://localhost:20299/oauth2/token/authorize/header",
        username: "johndoe",
        password: "A3ddj3w",
        clientId: "3MVG9YDQS5WtC11paU2WcQjBB3L5w4gz52uriT8ksZ3nUVjKvrfQMrU4uvZohTftxStwNEW4cfStBEGRxRL68",
        clientSecret: "9205371918321623741",
        scopes: ["token-scope1", "token-scope2"],
        refreshConfig: {
            refreshUrl: "https://localhost:20299/oauth2/token/refresh",
            scopes: ["token-scope1", "token-scope2"],
            clientConfig: {
                secureSocket: {
                   trustStore: {
                       path: TRUSTSTORE_PATH,
                       password: "ballerina"
                   }
                }
            }
        },
        clientConfig: {
            secureSocket: {
               trustStore: {
                   path: TRUSTSTORE_PATH,
                   password: "ballerina"
               }
            }
        }
    });
    http:BearerAuthHandler oauth2Handler6 = new(oauth2Provider6);
    http:Client clientEP6 = new("https://localhost:20298", {
        auth: {
            authHandler: oauth2Handler6
        },
        secureSocket: {
           trustStore: {
               path: TRUSTSTORE_PATH,
               password: "ballerina"
           }
        }
    });

    http:Request req = new;
    var response = clientEP6->get("/foo/bar", req);
    if (response is http:Response) {
        assertContains(response, "access_granted");
    } else {
        test:assertFail(msg = "Test Failed! " + (<http:ClientError>response).message());
    }
}

@test:Config {}
public function testPasswordGrantType3() {
    // Test the password grant type with an invalid username, password, and a valid refresh config
    oauth2:OutboundOAuth2Provider oauth2Provider7 = new({
        tokenUrl: "https://localhost:20299/oauth2/token/authorize/header",
        username: "invalid_username",
        password: "invalid_password",
        clientId: "3MVG9YDQS5WtC11paU2WcQjBB3L5w4gz52uriT8ksZ3nUVjKvrfQMrU4uvZohTftxStwNEW4cfStBEGRxRL68",
        clientSecret: "9205371918321623741",
        scopes: ["token-scope1", "token-scope2"],
        refreshConfig: {
            refreshUrl: "https://localhost:20299/oauth2/token/refresh",
            scopes: ["token-scope1", "token-scope2"],
            clientConfig: {
                secureSocket: {
                   trustStore: {
                       path: TRUSTSTORE_PATH,
                       password: "ballerina"
                   }
                }
            }
        },
        clientConfig: {
            secureSocket: {
               trustStore: {
                   path: TRUSTSTORE_PATH,
                   password: "ballerina"
               }
            }
        }
    });
    http:BearerAuthHandler oauth2Handler7 = new(oauth2Provider7);
    http:Client clientEP7 = new("https://localhost:20298", {
        auth: {
            authHandler: oauth2Handler7
        },
        secureSocket: {
           trustStore: {
               path: TRUSTSTORE_PATH,
               password: "ballerina"
           }
        }
    });

    http:Request req = new;
    var response = clientEP7->get("/foo/bar", req, string);
    if (response is http:ClientError) {
        assertContains(response, "unauthorized_client");
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response);
    }
}

@test:Config {}
public function testPasswordGrantType4() {
    // Test the password grant type with a bearer without credentials and a valid username and password
    oauth2:OutboundOAuth2Provider oauth2Provider8 = new({
        credentialBearer: http:NO_BEARER,
        tokenUrl: "https://localhost:20299/oauth2/token/authorize/none",
        username: "johndoe",
        password: "A3ddj3w",
        scopes: ["token-scope1", "token-scope2"],
        clientConfig: {
            secureSocket: {
               trustStore: {
                   path: TRUSTSTORE_PATH,
                   password: "ballerina"
               }
            }
        }
    });
    http:BearerAuthHandler oauth2Handler8 = new(oauth2Provider8);
    http:Client clientEP8 = new("https://localhost:20298", {
        auth: {
            authHandler: oauth2Handler8
        },
        secureSocket: {
           trustStore: {
               path: TRUSTSTORE_PATH,
               password: "ballerina"
           }
        }
    });

    http:Request req = new;
    var response = clientEP8->get("/foo/bar", req);
    if (response is http:Response) {
        assertContains(response, "access_granted");
    } else {
        test:assertFail(msg = "Test Failed! " + (<http:ClientError>response).message());
    }
}

@test:Config {}
public function testDirectToken1() {
    // Test the direct token mode with valid credentials and without a refresh config
    oauth2:OutboundOAuth2Provider oauth2Provider9 = new({
        accessToken: "2YotnFZFEjr1zCsicMWpAA"
    });
    http:BearerAuthHandler oauth2Handler9 = new(oauth2Provider9);
    http:Client clientEP9 = new("https://localhost:20298", {
        auth: {
            authHandler: oauth2Handler9
        },
        secureSocket: {
           trustStore: {
               path: TRUSTSTORE_PATH,
               password: "ballerina"
           }
        }
    });

    http:Request req = new;
    var response = clientEP9->get("/foo/bar", req);
    if (response is http:Response) {
        assertContains(response, "access_granted");
    } else {
        test:assertFail(msg = "Test Failed! " + (<http:ClientError>response).message());
    }
}

@test:Config {}
public function testDirectToken2() {
    // Test the direct token mode with an invalid access token and without a refresh config
    oauth2:OutboundOAuth2Provider oauth2Provider10 = new({
        accessToken: "invalid_access_token"
    });
    http:BearerAuthHandler oauth2Handler10 = new(oauth2Provider10);
    http:Client clientEP10 = new("https://localhost:20298", {
        auth: {
            authHandler: oauth2Handler10
        },
        secureSocket: {
           trustStore: {
               path: TRUSTSTORE_PATH,
               password: "ballerina"
           }
        }
    });

    http:Request req = new;
    var response = clientEP10->get("/foo/bar", req, string);
    if (response is http:ClientError) {
        assertContains(response, "Failed to refresh access token since DirectRefreshTokenConfig is not provided.");
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response);
    }
}

@test:Config {}
public function testDirectToken3() {
    // Test the direct token mode with an invalid access token and a valid refresh config
    oauth2:OutboundOAuth2Provider oauth2Provider11 = new({
        accessToken: "invalid_access_token",
        refreshConfig: {
            refreshUrl: "https://localhost:20299/oauth2/token/refresh",
            refreshToken: "XlfBs91yquexJqDaKEMzVg==",
            clientId: "3MVG9YDQS5WtC11paU2WcQjBB3L5w4gz52uriT8ksZ3nUVjKvrfQMrU4uvZohTftxStwNEW4cfStBEGRxRL68",
            clientSecret: "9205371918321623741",
            scopes: ["token-scope1", "token-scope2"],
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
    http:BearerAuthHandler oauth2Handler11 = new(oauth2Provider11);
    http:Client clientEP11 = new("https://localhost:20298", {
        auth: {
            authHandler: oauth2Handler11
        },
        secureSocket: {
           trustStore: {
               path: TRUSTSTORE_PATH,
               password: "ballerina"
           }
        }
    });

    http:Request req = new;
    var response = clientEP11->get("/foo/bar", req);
    if (response is http:Response) {
        assertContains(response, "access_granted");
    } else {
        test:assertFail(msg = "Test Failed! " + (<http:ClientError>response).message());
    }
}

@test:Config {}
public function testDirectToken4() {
    // Test the direct token mode (with the retrying request set as false) with an invalid access token and without a refresh config
    oauth2:OutboundOAuth2Provider oauth2Provider12 = new({
        accessToken: "invalid_access_token",
        retryRequest: false
    });
    http:BearerAuthHandler oauth2Handler12 = new(oauth2Provider12);
    http:Client clientEP12 = new("https://localhost:20298", {
        auth: {
            authHandler: oauth2Handler12
        },
        secureSocket: {
           trustStore: {
               path: TRUSTSTORE_PATH,
               password: "ballerina"
           }
        }
    });

    http:Request req = new;
    var response = clientEP12->get("/foo/bar", req, string);
    if (response is http:ClientError) {
        assertContains(response, "Failed to get the access token since retry request is set as false.");
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response);
    }
}

@test:Config {}
public function testDirectToken5() {
    // Test the direct token mode (with the retrying request set as false) with an invalid access token and a valid refresh config
    oauth2:OutboundOAuth2Provider oauth2Provider13 = new({
        accessToken: "invalid_access_token",
        retryRequest: false,
        refreshConfig: {
            refreshUrl: "https://localhost:20299/oauth2/token/refresh",
            refreshToken: "XlfBs91yquexJqDaKEMzVg==",
            clientId: "3MVG9YDQS5WtC11paU2WcQjBB3L5w4gz52uriT8ksZ3nUVjKvrfQMrU4uvZohTftxStwNEW4cfStBEGRxRL68",
            clientSecret: "9205371918321623741",
            scopes: ["token-scope1", "token-scope2"],
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
    http:BearerAuthHandler oauth2Handler13 = new(oauth2Provider13);
    http:Client clientEP13 = new("https://localhost:20298", {
        auth: {
            authHandler: oauth2Handler13
        },
        secureSocket: {
           trustStore: {
               path: TRUSTSTORE_PATH,
               password: "ballerina"
           }
        }
    });

    http:Request req = new;
    var response = clientEP13->get("/foo/bar", req);
    if (response is http:ClientError) {
        assertContains(response, "Failed to get the access token since retry request is set as false.");
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response);
    }
}

@test:Config {}
public function testDirectToken6() {
    // Test the direct token mode with an invalid access token and an invalid refresh config
    oauth2:OutboundOAuth2Provider oauth2Provider14 = new({
        accessToken: "invalid_access_token",
        refreshConfig: {
            refreshUrl: "https://localhost:20299/oauth2/token/refresh",
            refreshToken: "invalid_refresh_token",
            clientId: "3MVG9YDQS5WtC11paU2WcQjBB3L5w4gz52uriT8ksZ3nUVjKvrfQMrU4uvZohTftxStwNEW4cfStBEGRxRL68",
            clientSecret: "9205371918321623741",
            scopes: ["token-scope1", "token-scope2"],
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
    http:BearerAuthHandler oauth2Handler14 = new(oauth2Provider14);
    http:Client clientEP14 = new("https://localhost:20298", {
        auth: {
            authHandler: oauth2Handler14
        },
        secureSocket: {
           trustStore: {
               path: TRUSTSTORE_PATH,
               password: "ballerina"
           }
        }
    });

    http:Request req = new;
    var response = clientEP14->get("/foo/bar", req);
    if (response is http:ClientError) {
        assertContains(response, "invalid_grant");
    } else {
        test:assertFail(msg = "Test Failed! " + <string>response);
    }
}

@test:Config {}
public function testDirectToken7() {
    // Test the direct token mode with valid credentials (with the retrying request set as false) and without a refresh config
    oauth2:OutboundOAuth2Provider oauth2Provider15 = new({
        accessToken: "2YotnFZFEjr1zCsicMWpAA",
        retryRequest: false
    });
    http:BearerAuthHandler oauth2Handler15 = new(oauth2Provider15);
    http:Client clientEP15 = new("https://localhost:20298", {
        auth: {
            authHandler: oauth2Handler15
        },
        secureSocket: {
           trustStore: {
               path: TRUSTSTORE_PATH,
               password: "ballerina"
           }
        }
    });

    http:Request req = new;
    var response = clientEP15->get("/foo/bar", req);
    if (response is http:Response) {
        assertContains(response, "access_granted");
    } else {
        test:assertFail(msg = "Test Failed! " + (<http:ClientError>response).message());
    }
}
