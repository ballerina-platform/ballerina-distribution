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

// Client endpoint configuration
HelloWorldClient ep = check new("http://localhost:20001");

@test:Config {}
function testUnaryBlockingService() returns error? {
    // Setting the custom headers.
    ContextString requestMessage =
    {content: "WSO2", headers: {client_header_key: "0987654321"}};

    // Executing the unary call.
    ContextString|error result = ep->helloContext(requestMessage);
    if (result is error) {
        test:assertFail(string `Error from Connector: ${result.message()}`);
    } else {
        string expected = "Hello WSO2";
        test:assertEquals(result.content, expected);
        string headerValue = check grpc:getHeader(result.headers, "server_header_key");
        string expectedHeaderValue = "Response Header value";
        test:assertEquals(headerValue, expectedHeaderValue);
    }
}
