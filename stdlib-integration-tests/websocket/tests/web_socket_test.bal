// Copyright (c) 2020 WSO2 Inc. (//www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// //www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/lang.runtime as runtime;
import ballerina/test;
import ballerina/http;
import ballerina/websocket;
import ballerina/io;

string data = "";

service /onTextString on new websocket:Listener(21003) {
   resource isolated function get .(http:Request req) returns websocket:Service|websocket:Error {
       return new WsService1();
   }
}

service class WsService1 {
  *websocket:Service;
  remote isolated function onString(websocket:Caller caller, string data) {
      checkpanic caller->writeString(data);
  }
}

service class clientPushCallbackService {
    *websocket:Service;
    remote function onString(websocket:Caller wsEp, string text) {
        data = <@untainted>text;
    }

    remote isolated function onError(websocket:Caller wsEp, error err) {
        io:println(err);
    }
}

// Tests string support for writeString and onString
@test:Config {}
public function testWebsocketString() returns websocket:Error? {
    websocket:AsyncClient wsClient = check new ("ws://localhost:21003/onTextString", new clientPushCallbackService());
    checkpanic wsClient->writeString("Hi");
    runtime:sleep(5);
    test:assertEquals(data, "Hi", msg = "Failed pushtext");
    var closeResp = wsClient->close(statusCode = 1000, reason = "Close the connection", timeoutInSeconds = 180);
}
