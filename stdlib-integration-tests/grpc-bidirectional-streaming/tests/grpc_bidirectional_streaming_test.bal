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

import ballerina/grpc;
import ballerina/io;
import ballerina/runtime;
import ballerina/test;

//Client endpoint configuration.
ChatClient chatEp = new("http://localhost:20006");
const string ERROR_MSG_FORMAT = "Error from Connector: %s";
boolean received = false;
string responseMsg = "";

@test:Config {}
function testBidiStreamingService() {
    grpc:StreamingClient ep;
    // Executes unary non-blocking call registering server message listener.
    var res = chatEp->chat(MessageListener);
    if (res is grpc:Error) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, res.message()));
        return;
    } else {
        io:println("Initialized connection sucessfully.");
        ep = res;
    }

    // Sends multiple messages to the server.
    ChatMessage mes = { name: "Sam", message: "Hi" };
    grpc:Error? connErr = ep->send(mes);
    if (connErr is grpc:Error) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, connErr.message()));
    }

    int waitCount = 0;
    while(!received) {
        io:println(responseMsg);
        runtime:sleep(1000);
        if (waitCount > 10) {
            break;
        }
        waitCount += 1;
    }
    test:assertEquals(received, true, msg = "Server message didn't receive.");
    string expected = "Sam: Hi";
    test:assertEquals(responseMsg, expected);
    // Once all messages are sent, client send complete message to notify the server, I am done.
    checkpanic ep->complete();
}

service MessageListener = service {

    // Resource registered to receive server messages.
    resource function onMessage(string message) {
        responseMsg = <@untainted> message;
        received = true;
        io:println("Response received from server: " + message);
    }

    // Resource registered to receive server error messages.
    resource function onError(error err) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, err.message()));
        received = true;
    }

    // Resource registered to receive server completed message.
    resource function onComplete() {
        received = true;
        io:println("Server Complete Sending Responses.");
    }
};
