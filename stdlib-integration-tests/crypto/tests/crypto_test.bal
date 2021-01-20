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

import ballerina/config;
import ballerina/crypto;
import ballerina/test;

@test:Config {}
function testDecodePrivateKey() {
    crypto:KeyStore keyStore = {
        path: config:getAsString("b7a.home") +
              "/bre/security/ballerinaKeystore.p12",
        password: "ballerina"
    };
    var result = crypto:decodePrivateKey(keyStore, "ballerina", "ballerina");
    if (result is crypto:PrivateKey) {
        test:assertEquals(result.algorithm, "RSA", msg = "Invalid algorithm of decoded private key.");
    } else {
        test:assertFail(msg = "Test Failed! " + <string>result.message());
    }
}

@test:Config {}
function testDecodePublicKey() {
    crypto:TrustStore truststore = {
        path: config:getAsString("b7a.home") +
              "/bre/security/ballerinaTruststore.p12",
        password: "ballerina"
    };
    var result = crypto:decodePublicKey(truststore, "ballerina");
    if (result is crypto:PublicKey) {
        test:assertEquals(result.algorithm, "RSA", msg = "Invalid algorithm of decoded public key.");
    } else {
        test:assertFail(msg = "Test Failed! " + <string>result.message());
    }
}
