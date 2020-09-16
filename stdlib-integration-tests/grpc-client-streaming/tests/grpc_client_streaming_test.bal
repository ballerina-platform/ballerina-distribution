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
import ballerina/grpc;
import ballerina/runtime;
import ballerina/test;

// Client endpoint configuration.
HelloWorldClient helloWorldEp = new("http://localhost:20005");
const string ERROR_MSG_FORMAT = "Error from Connector: %s";
boolean completed = false;
string responseMsg = "";

@test:Config {}
function testClientStreamingService() {
    grpc:StreamingClient ep;
    // Execute the unary non-blocking call that registers a server message listener.
    var res = helloWorldEp->lotsOfGreetings(MessageListener);
    if (res is error) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, res.message()));
        return;
    } else {
        io:println("Initialized connection sucessfully.");
        ep = res;
    }

    // Send multiple messages to the server.
    string[] greets = ["Hi", "Hey", "GM"];
    var name = "John";
    foreach string greet in greets {
        error? connErr = ep->send(greet + " " + name);
        if (connErr is error) {
            test:assertFail(io:sprintf(ERROR_MSG_FORMAT, connErr.message()));
        } else {
            io:println("Send greeting: " + greet + " " + name);
        }
    }
    // Once all the messages are sent, the server notifies the caller with a `complete` message.
    checkpanic ep->complete();

    int waitCount = 0;
    while(!completed) {
        runtime:sleep(1000);
        if (waitCount > 10) {
            break;
        }
        waitCount += 1;
    }
    test:assertEquals(completed, true, msg = "Incomplete response message.");
    string expected = "Ack";
    test:assertEquals(responseMsg, expected);
}

// Server Message Listener.
service MessageListener = service {

    // Resource registered to receive server messages.
    resource function onMessage(string message) {
        completed = true;
        responseMsg = <@untainted> message;
        io:println("Response received from server: " + message);
    }

    // Resource registered to receive server error messages.
    resource function onError(error err) {
        completed = true;
        responseMsg = io:sprintf(ERROR_MSG_FORMAT, err.message());
    }

    // Resource registered to receive server completed messages.
    resource function onComplete() {
        completed = true;
        io:println("Server Complete Sending Responses.");
    }
};
