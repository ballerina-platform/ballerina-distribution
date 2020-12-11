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

import ballerina/http;
import ballerina/test;
import ballerina/io;

http:Client clientEndpoint = new ("http://localhost:58291");

@test:Config {}
function testHttpClientEcho() {
    io:println("testing ....tcp");
    http:Request req = new;
    req.addHeader("Content-Type", "text/plain");
    string requestMessage = "Hello Ballerina";
    var response = clientEndpoint->post("/echo", requestMessage);

    if (response is http:Response) {
        test:assertEquals(response.statusCode, http:STATUS_ACCEPTED, "Unexpected response code");
    } else if (response is http:ClientError)  {
        test:assertFail(msg = (<error>response).message());
    }
}
