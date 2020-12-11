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

import ballerina/runtime;
import ballerina/test;
import ballerina/http;
import ballerina/websocket;
import ballerina/io;

string data = "";

service websocket:UpgradeService /onTextString on new websocket:Listener(21003) {
   remote isolated function onUpgrade(http:Caller caller, http:Request req) returns websocket:Service|websocket:WebSocketError {
       return new WsService1();
   }
}

service class WsService1 {
  *websocket:Service;
  remote isolated function onText(websocket:Caller caller, string data, boolean finalFrame) {
      checkpanic caller->pushText(data);
  }
}

service object {} clientPushCallbackService = service object {
    remote function onText(websocket:Client wsEp, string text) {
        data = <@untainted>text;
    }

    remote isolated function onError(websocket:Client wsEp, error err) {
        io:println(err);
    }
};

// Tests string support for pushText and onText
@test:Config {}
public function testString() {
    websocket:Client wsClient = new ("ws://localhost:21003/onTextString", {callbackService: clientPushCallbackService});
    checkpanic wsClient->pushText("Hi");
    runtime:sleep(500);
    test:assertEquals(data, "Hi", msg = "Failed pushtext");
    var closeResp = wsClient->close(statusCode = 1000, reason = "Close the connection", timeoutInSeconds = 180);
}
