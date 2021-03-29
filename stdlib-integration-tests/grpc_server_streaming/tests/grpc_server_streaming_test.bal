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
import ballerina/test;

@test:Config {}
function testServerStreamingService() returns error? {
    // Client endpoint configuration.
    HelloWorldClient streamingEp = check new("http://localhost:20003");

    // Execute the unary non-blocking call that registers the server message listener.
    stream<string, grpc:Error?> result = check streamingEp->lotsOfReplies("Sam");

    string expectedMsg1 = "Hi Sam";
    string expectedMsg2 = "Hey Sam";
    string expectedMsg3 = "GM Sam";

    // Iterate through the stream and print the content.
    error? e = result.forEach(function(string str) {
        test:assertTrue(str == expectedMsg1 || str == expectedMsg2 || str == expectedMsg3);
    });
    test:assertEquals(e, ());
}
