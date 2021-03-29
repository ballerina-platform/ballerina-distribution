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

import ballerina/test;

// Client endpoint configuration.
HelloWorldClient helloWorldEp = check new("http://localhost:20005");

@test:Config {}
function testClientStreamingService() returns error? {
    // Send multiple messages to the server.
    string[] requests = ["Hi Sam", "Hey Sam", "GM Sam"];
    // Execute the client-streaming RPC call and receive the streaming client.
    LotsOfGreetingsStreamingClient streamingClient = check helloWorldEp->lotsOfGreetings();
    // Send multiple messages to the server.
    foreach var greet in requests {
        check streamingClient->sendstring(greet);
    }
    // Once all the messages are sent, the server notifies the caller with a `complete` message.
    check streamingClient->complete();

    string? response = check streamingClient->receiveString();
    if response is string {
        string expected = "Ack";
        test:assertEquals(response, expected);
    } else {
        test:assertFail(string `Error from Connector: connection closed before receiving the response`);
    }

}
