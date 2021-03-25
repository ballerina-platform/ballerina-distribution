// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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
import ballerina/test;

listener http:Listener authListener = new(25001, {
    secureSocket: {
        key: {
            path: "tests/resources/keystore/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
});

@http:ServiceConfig {
    auth: [
        {
            fileUserStoreConfig: {},
            scopes: ["Admin"]
        },
        {
            ldapUserStoreConfig: {
                domainName: "avix.lk",
                connectionUrl: "ldap://localhost:389",
                connectionName: "cn=admin,dc=avix,dc=lk",
                connectionPassword: "avix123",
                userSearchBase: "ou=Users,dc=avix,dc=lk",
                userEntryObjectClass: "inetOrgPerson",
                userNameAttribute: "uid",
                userNameSearchFilter: "(&(objectClass=inetOrgPerson)(uid=?))",
                userNameListFilter: "(objectClass=inetOrgPerson)",
                groupSearchBase: ["ou=Groups,dc=avix,dc=lk"],
                groupEntryObjectClass: "groupOfNames",
                groupNameAttribute: "cn",
                groupNameSearchFilter: "(&(objectClass=groupOfNames)(cn=?))",
                groupNameListFilter: "(objectClass=groupOfNames)",
                membershipAttribute: "member",
                userRolesCacheEnabled: true,
                connectionPoolingEnabled: false,
                connectionTimeout: 5000,
                readTimeout: 60000
            },
            scopes: ["Admin"]
        }
    ]
}
service /foo on authListener {
    resource function get bar() returns string {
        return "Hello World!";
    }
}

@test:Config {}
public function testAuthModuleFileUserStore1() {
    http:Client clientEP = checkpanic new("https://localhost:25001", {
        secureSocket: {
           cert: {
               path: "tests/resources/keystore/ballerinaTruststore.p12",
               password: "ballerina"
           }
        },
        auth: {
            username: "alice",
            password: "123"
        }
    });
    var response = clientEP->get("/foo/bar");
    if (response is http:Response) {
        assertOK(response);
    } else {
        test:assertFail(msg = "Test Failed!");
    }
}

@test:Config {}
public function testAuthModuleFileUserStore2() {
    http:Client clientEP = checkpanic new("https://localhost:25001", {
        secureSocket: {
           cert: {
               path: "tests/resources/keystore/ballerinaTruststore.p12",
               password: "ballerina"
           }
        },
        auth: {
            username: "bob",
            password: "456"
        }
    });
    var response = clientEP->get("/foo/bar");
    if (response is http:Response) {
        assertForbidden(response);
    } else {
        test:assertFail(msg = "Test Failed!");
    }
}

@test:Config {}
public function testAuthModuleFileUserStore3() {
    http:Client clientEP = checkpanic new("https://localhost:25001", {
        secureSocket: {
           cert: {
               path: "tests/resources/keystore/ballerinaTruststore.p12",
               password: "ballerina"
           }
        },
        auth: {
            username: "eve",
            password: "789"
        }
    });
    var response = clientEP->get("/foo/bar");
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed!");
    }
}

@test:Config {}
public function testAuthModuleLdapUserStore1() {
    http:Client clientEP = checkpanic new("https://localhost:25001", {
        secureSocket: {
           cert: {
               path: "tests/resources/keystore/ballerinaTruststore.p12",
               password: "ballerina"
           }
        },
        auth: {
            username: "ldclakmal",
            password: "ldclakmal123"
        }
    });
    var response = clientEP->get("/foo/bar");
    if (response is http:Response) {
        assertOK(response);
    } else {
        test:assertFail(msg = "Test Failed!");
    }
}

@test:Config {}
public function testAuthModuleLdapUserStore2() {
    http:Client clientEP = checkpanic new("https://localhost:25001", {
        secureSocket: {
           cert: {
               path: "tests/resources/keystore/ballerinaTruststore.p12",
               password: "ballerina"
           }
        },
        auth: {
            username: "alice",
            password: "alice123"
        }
    });
    var response = clientEP->get("/foo/bar");
    if (response is http:Response) {
        assertForbidden(response);
    } else {
        test:assertFail(msg = "Test Failed!");
    }
}

@test:Config {}
public function testAuthModuleLdapUserStore3() {
    http:Client clientEP = checkpanic new("https://localhost:25001", {
        secureSocket: {
           cert: {
               path: "tests/resources/keystore/ballerinaTruststore.p12",
               password: "ballerina"
           }
        },
        auth: {
            username: "eve",
            password: "eve123"
        }
    });
    var response = clientEP->get("/foo/bar");
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed!");
    }
}

function assertOK(http:Response res) {
    test:assertEquals(res.statusCode, http:STATUS_OK, msg = "Response code mismatched");
}

function assertUnauthorized(http:Response res) {
    test:assertEquals(res.statusCode, http:STATUS_UNAUTHORIZED, msg = "Response code mismatched");
}

function assertForbidden(http:Response res) {
    test:assertEquals(res.statusCode, http:STATUS_FORBIDDEN, msg = "Response code mismatched");
}
