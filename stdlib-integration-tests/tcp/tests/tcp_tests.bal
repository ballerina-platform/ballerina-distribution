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

import ballerina/test;
import ballerina/io;
import ballerina/tcp;

@test:Config {}
function testClientEcho() returns  @tainted error? {
    tcp:Client socketClient = check new ("localhost", PORT1);

    string msg = "Hello Ballerina Echo from client";
    byte[] msgByteArray = msg.toBytes();
    check  socketClient->writeBytes(msgByteArray);

    readonly & byte[] receivedData = check socketClient->readBytes();
    test:assertEquals(string:fromBytes(receivedData), msg, "Found unexpected output");

    check socketClient->close();
}

@test:Config {
    dependsOn: [testClientEcho]
}
function testClientReadTimeout() returns  @tainted error? {
    tcp:Client socketClient = check new ("localhost", PORT2, timeout = 1);

    string msg = "Do not reply";
    byte[] msgByteArray = msg.toBytes();
    check  socketClient->writeBytes(msgByteArray);

    tcp:Error|(readonly & byte[]) res = socketClient->readBytes();
    if (res is (readonly & byte[])) {
        test:assertFail(msg = "Read timeout test failed");
        io:println(res.length());
    }
    // print expected timeout error
    io:println(res);

    check socketClient->close();
}

@test:Config {
    dependsOn: [testClientReadTimeout]
}
function testServerAlreadyClosed() returns  @tainted error? {
    tcp:Client socketClient = check new ("localhost", PORT3, timeout = 1);

    tcp:Error|(readonly & byte[]) res = socketClient->readBytes();
    if (res is (readonly & byte[])) {
        test:assertFail(msg = "Test for server already disconnected failed");
        io:println(res.length());
    }
    // print expected timeout error
    io:println(res);

    check socketClient->close();
}

@test:Config {dependsOn: [testServerAlreadyClosed]}
function testSecureListenerWithSecureClient() returns @tainted error? {
    tcp:Client socketClient = check new ("localhost", PORT4, secureSocket = {
        cert: certPath,
        protocol: {
            name: tcp:TLS,
            versions: ["TLSv1.2", "TLSv1.1"]
        },
        ciphers: ["TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA"]
    });

    string msg = "Hello Ballerina Echo from secure client";
    byte[] msgByteArray = msg.toBytes();
    check socketClient->writeBytes(msgByteArray);

    readonly & byte[] receivedData = check socketClient->readBytes();
    test:assertEquals('string:fromBytes(receivedData), msg, "Found unexpected output");

    check socketClient->close();
}
