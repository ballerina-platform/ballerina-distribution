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
import ballerina/stringutils;
import ballerina/test;

const string KEYSTORE_PATH = "src/oauth2/tests/resources/keystore/ballerinaKeystore.p12";
const string TRUSTSTORE_PATH = "src/oauth2/tests/resources/keystore/ballerinaTruststore.p12";

function assertOK(http:Response res) {
    test:assertEquals(res.statusCode, http:STATUS_OK, msg = "Response code mismatched");
}

function assertUnauthorized(http:Response res) {
    test:assertEquals(res.statusCode, http:STATUS_UNAUTHORIZED, msg = "Response code mismatched");
}

function assertForbidden(http:Response res) {
    test:assertEquals(res.statusCode, http:STATUS_FORBIDDEN, msg = "Response code mismatched");
}

function assertContains(http:Response|http:ClientError res, string text) {
    if (res is http:Response) {
        var payload = res.getTextPayload();
        test:assertFalse(trap <string>payload is error);
        test:assertTrue(stringutils:contains(<string>payload, text));
    } else {
        string message = res.message();
        var cause = res.cause();
        if (cause is error) {
            var innerCause = cause.cause();
            while (innerCause is error) {
                cause = innerCause;
                innerCause = innerCause.cause();
            }
            message = cause.message();
        }
        test:assertTrue(stringutils:contains(message, text));
    }
}
