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
import ballerina/test;

// Client endpoint configuration
HelloWorldBlockingClient blockingEp = new("http://localhost:20001");
const string ERROR_MSG_FORMAT = "Error from Connector: %s";

@test:Config {}
function testUnaryBlockingService() {
    // Writes custom headers to request message.
    grpc:Headers headers = new;
    headers.setEntry("client_header_key", "Request Header Value");

    // Executes unary blocking call with headers.
    var unionResp = blockingEp->hello("WSO2", headers);
    if (unionResp is error) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, unionResp.message()));
    } else {
        string result;
        grpc:Headers resHeaders;
        [result, resHeaders] = unionResp;
        string expected = "Hello WSO2";
        test:assertEquals(result, expected);
        string headerValue = resHeaders.get("server_header_key") ?: "none";
        string expectedHeaderValue = "Response Header value";
        test:assertEquals(headerValue, expectedHeaderValue);
    }
}
