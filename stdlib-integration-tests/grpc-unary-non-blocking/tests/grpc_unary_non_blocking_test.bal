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
HelloWorldClient helloWorldEp = new("http://localhost:20002");
const string ERROR_MSG_FORMAT = "Error from Connector: %s";
boolean completed = false;
string responseMsg = "";

@test:Config {}
function testUnaryNonBlockingClient() {
    // Execute the unary non-blocking call that registers the server message listener.
    error? result = helloWorldEp->hello("WSO2", messageListener);
    if (result is error) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, result.message()));
    } else {
        io:println("Connected successfully");
    }

    int waitCount = 0;
    while(!completed) {
        runtime:sleep(1000);
        if (waitCount > 10) {
            break;
        }
        waitCount += 1;
    }
    test:assertEquals(completed, true, msg = "Incomplete response message.");
    string expected = "Hello WSO2";
    test:assertEquals(responseMsg, expected);
}

// Server Message Listener.
service object {}  messageListener = service object {

    // Resource registered to receive server messages.
    function onMessage(string message) {
        responseMsg = <@untainted>message;
    }

    // Resource registered to receive server error messages.
    function onError(error err) {
        responseMsg = io:sprintf(ERROR_MSG_FORMAT, err.message());
    }

    // Resource registered to receive server completed messages.
    function onComplete() {
        test:assertTrue(true);
        io:println("Server Complete Sending Response.");
        completed = true;
    }
};
