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
import ballerina/lang.runtime;
import ballerina/test;

//Client endpoint configuration.
ChatClient chatEp = check new("http://localhost:20006");
const string ERROR_MSG_FORMAT = "Error from Connector: %s";

@test:Config {}
function testBidiStreamingService() returns error? {
    // Executes the RPC call and receives the customized streaming client.
    ChatStreamingClient streamingClient = check chatEp->chat();

    // Reads response from the server.
    _ = start readResponses(streamingClient);

    // Sends multiple messages to the server.
    ChatMessage mes = { name: "Sam", message: "Hi" };
    grpc:Error? connErr = streamingClient->sendChatMessage(mes);
    if (connErr is grpc:Error) {
        test:assertFail(string `Error from Connector: ${connErr.message()}`);
    }

    runtime:sleep(5000);
    // Once all messages are sent, client send complete message to notify the server, I am done.
    check streamingClient->complete();
}

public function readResponses(ChatStreamingClient streamingClient) returns error? {
   string? response = check streamingClient->receiveString();
   while !(response is ()) {
      string expected = "Sam: Hi";
      test:assertEquals(response, expected);
      response = check streamingClient->receiveString();
   }
}

