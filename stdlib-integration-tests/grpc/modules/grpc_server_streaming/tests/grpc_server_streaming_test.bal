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
import ballerina/runtime;
import ballerina/test;

// Client endpoint configuration.
HelloWorldClient streamingEp = new("http://localhost:20003");
const string ERROR_MSG_FORMAT = "Error from Connector: %s";
boolean completed = false;
string respError = "";
string[] responseMsgs = [];
int msgCount = 0;

@test:Config {}
function testServerStreamingService() {
    // Execute the unary non-blocking call that registers the server message listener.
    error? result = streamingEp->lotsOfReplies("Sam", messageListener);
    if (result is error) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, result.message()));
    } else {
        io:println("Connected successfully");
    }

    int waitCount = 0;
    while(true) {
        if (completed && (responseMsgs.length() == 3)) {
            break;
        }
        io:println(responseMsgs);
        runtime:sleep(1000);
        if (waitCount > 10) {
            break;
        }
        waitCount += 1;
    }
    test:assertEquals(completed, true, msg = "Incomplete response message.");
    string expectedMsg1 = "Hi Sam";
    string expectedMsg2 = "Hey Sam";
    string expectedMsg3 = "GM Sam";
    foreach string msg in responseMsgs {
        test:assertTrue(msg == expectedMsg1 || msg == expectedMsg2 || msg == expectedMsg3);
    }
    test:assertEquals(respError, "");
}

// Server Message Listener.
service object{} messageListener = service object {

    // Resource registered to receive server messages.
    function onMessage(string message) {
        responseMsgs[msgCount] = <@untainted> message;
        msgCount = msgCount + 1;
    }

    // Resource registered to receive server error messages.
    function onError(error err) {
        respError = io:sprintf(ERROR_MSG_FORMAT, err.message());
    }

    // Resource registered to receive server completed messages.
    function onComplete() {
        test:assertTrue(true);
        io:println("Server Complete Sending Response.");
        completed = true;
    }
};
