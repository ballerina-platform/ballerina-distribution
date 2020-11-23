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

import ballerina/io;
import ballerina/log;
import ballerina/socket;

service echoServer on new socket:Listener(61599) {

    resource function onConnect(socket:Caller caller) {
        log:printInfo("Client connected: " + caller.id.toString());
    }

    resource function onReadReady(socket:Caller caller) {
        var result = caller->read();
        if (result is [byte[], int]) {
            var [content, length] = result;
            if (length > 0) {

                var byteChannel =
                io:createReadableChannel(content);
                if (byteChannel is io:ReadableByteChannel) {
                    var str = io:channelReadString(byteChannel);
                    if (str is string) {
                        string reply = <@untainted>str;
                        byte[] payloadByte = reply.toBytes();

                        int i = 0;
                        int arrayLength = payloadByte.length();
                        while (i < arrayLength) {
                            var writeResult = caller->write(payloadByte);
                            if (writeResult is int) {
                                log:printInfo("Number of bytes written: "
                                    + writeResult.toString());
                                i = i + writeResult;
                                payloadByte = payloadByte.slice(writeResult,
                                                                arrayLength);
                            } else {
                                log:printError("Unable to write the content",
                                    writeResult);
                            }
                        }
                    } else {
                        log:printError("Error while writing content to " +
                                        "the caller", str);
                    }
                }
            } else {
                log:printInfo("Client left: " + caller.id.toString());
            }
        } else {
            io:println(result);
        }
    }

    resource function onError(socket:Caller caller, error er) {
        log:printError("An error occurred", er);
    }
}
