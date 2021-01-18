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
import ballerina/io;

function getString(byte[] content, int numberOfBytes = 50) returns @tainted string|io:Error {
    io:ReadableByteChannel byteChannel = check io:createReadableChannel(content);
    io:ReadableCharacterChannel characterChannel = new io:ReadableCharacterChannel(byteChannel, "UTF-8");
    return check characterChannel.read(numberOfBytes);
}

isolated function prepareDatagram(string msg, string remoteHost = "localhost", int remotePort = 9001) returns udp:Datagram {
    byte[] data =  msg.toBytes();
    return { data, remoteHost: remoteHost, remotePort: remotePort };
}

function receiveClientContent(udp:Client socketClient) returns string {
    string returnStr = "";
    var result = socketClient->receiveDatagram();
    if (result is (readonly & udp:Datagram)) {
        var str = getString(result.data);
        if (str is string) {
            returnStr = <@untainted>str;
            io:println("Response is :", returnStr);
        } else {
            test:assertFail(msg = str.message());
        }
    } else {
        test:assertFail(msg = "Failed to receive the datagram");
    }
    return returnStr;
}

@test:Config { }
function testConnectionlessClient() {
    udp:Client|udp:Error? socketClient = new(localHost = "localhost");
    if (socketClient is udp:Client) {
        string msg = "hi";
        string expectedResponse = "hi there!";
        udp:Datagram datagram = prepareDatagram(msg);

        var sendResult = socketClient->sendDatagram(datagram);
        if (sendResult is ()) {
            log:print("Datagram was sent to the remote host.");
        } else {
            test:assertFail(msg = sendResult.message());
        }
        string readContent = receiveClientContent(socketClient);
        test:assertEquals(readContent, expectedResponse, "Found unexpected output");
        checkpanic socketClient->close();
        
    } else if (socketClient is udp:Error) {
        log:printError("Error initializing UDP Client", err = socketClient);
    }
}

@test:Config { }
function testConnectClient() {
    udp:ConnectClient|udp:Error? socketClient = new("localhost", 9001);
    if (socketClient is udp:ConnectClient) {
        string msg = "who are you?";
        string expectedResponse = "I'm a ballerina bot";

        var sendResult = socketClient->writeBytes(msg.toBytes());
        if (sendResult is ()) {
            log:print("Data was sent to the remote host.");
        } else {
            test:assertFail(msg = sendResult.message());
        }
        string readContent = readConnectClientContent(socketClient);
        test:assertEquals(readContent, expectedResponse, "Found unexpected output");
        checkpanic socketClient->close();
        
    } else if (socketClient is udp:Error) {
        log:printError("Error initializing UDP Client", err = socketClient);
    }
}

@test:Config { }
isolated function testConnectClientReadTimeOut() {
    udp:ConnectClient|udp:Error? socketClient = new("www.ballerina.io", 48830, localHost = "localhost", timeoutInMillis = 1000);
    if (socketClient is ConnectClient) {
        
        var result = socketClient->readBytes();
        if (result is byte[]) {
            test:assertFail(msg = "No UDP service running on www.ballerina.io, no result should be returned");
        } else {
            log:print(result.message());
        }

        checkpanic socketClient->close();
        
    } else if (socketClient is udp:Error) {
        log:printError("Error initializing UDP Client", err = socketClient);
    }
}
