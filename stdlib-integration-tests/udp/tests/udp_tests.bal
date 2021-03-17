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

import ballerina/log;
import ballerina/test;
import ballerina/udp;

@test:Config {}
function testConnectionlessClient() returns error? {
    udp:Client socketClient = check new;
    string msg = "hi";
    string expectedResponseString = "hi there!";

    var sendResult = check socketClient->sendDatagram({
        data: msg.toBytes(),
        remoteHost: "localhost",
        remotePort: PORT1
    });
    log:printInfo("Datagram was sent to the remote host.");

    readonly & udp:Datagram result = check socketClient->receiveDatagram();
    test:assertEquals(string:fromBytes(result.data), expectedResponseString, "Found unexpected output");
    check socketClient->close();
}

@test:Config {}
function testConnectClient() returns error? {
    udp:ConnectClient socketClient = check new ("localhost", PORT1);

    string msg = "who are you?";
    string expectedResponseString = "I'm a ballerina bot";


    check socketClient->writeBytes(msg.toBytes());
    log:printInfo("Datagram was sent to the remote host.");

    readonly & byte[] result = check socketClient->readBytes();
    test:assertEquals(string:fromBytes(result), expectedResponseString, "Found unexpected output");

    check socketClient->close();
}

@test:Config {}
isolated function testConnectClientReadTimeOut() returns error? {
    udp:ConnectClient socketClient = check new ("localhost", 48830, localHost = "localhost", timeout = 1);

    var result = socketClient->readBytes();
    if (result is byte[]) {
        test:assertFail(msg = "No UDP service running on localhost:48830, no result should be returned");
    } else {
        log:printInfo(result.message());
    }

    check socketClient->close();
}
