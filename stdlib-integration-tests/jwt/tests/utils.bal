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
import ballerina/test;

const string KEYSTORE_PATH = "src/jwt/tests/resources/keystore/ballerinaKeystore.p12";
const string TRUSTSTORE_PATH = "src/jwt/tests/resources/keystore/ballerinaTruststore.p12";
const string EXPIRED_TRUSTSTORE_PATH = "src/jwt/tests/resources/keystore/expiredTruststore.p12";

function assertOK(http:Response res) {
    test:assertEquals(res.statusCode, http:STATUS_OK, msg = "Response code mismatched");
}

function assertUnauthorized(http:Response res) {
    test:assertEquals(res.statusCode, http:STATUS_UNAUTHORIZED, msg = "Response code mismatched");
}

function assertForbidden(http:Response res) {
    test:assertEquals(res.statusCode, http:STATUS_FORBIDDEN, msg = "Response code mismatched");
}
