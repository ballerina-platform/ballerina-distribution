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
// KIND, either express or implied. See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/io;
import ballerina/log;
import ballerina/socket;

const int PORT1 = 59152;

listener socket:Listener server1 = new (PORT1);

service echoServer on server1 {

    resource function onConnect(socket:Caller caller) {
        log:printInfo("Join: " + caller.remotePort.toString());
    }

    resource function onReadReady(socket:Caller caller) {
        var result = caller->read();
        if (result is [byte[], int]) {
            var [content, length] = result;
            if (length > 0) {
                _ = checkpanic caller->write(content);
                log:printInfo("Server write");
            } else {
                log:printInfo("Client close: " + caller.remotePort.toString());
            }
        } else {
            log:printError("Error on echo server read", <error>result);
        }
    }

    resource function onError(socket:Caller caller, error er) {
        log:printError("Error on echo service", <error>er);
    }
}

function getString(byte[] content, int numberOfBytes) returns @tainted string|io:Error {
    io:ReadableByteChannel byteChannel = check io:createReadableChannel(content);
    io:ReadableCharacterChannel characterChannel = new io:ReadableCharacterChannel(byteChannel, "UTF-8");
    return check characterChannel.read(numberOfBytes);
}
