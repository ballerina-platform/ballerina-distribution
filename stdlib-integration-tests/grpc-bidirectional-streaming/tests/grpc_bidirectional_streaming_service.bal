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
import ballerina/log;

map<grpc:Caller> consMap = {};

service Chat on new grpc:Listener(20006) {

    isolated resource function  chat(grpc:Caller caller,
                                stream<ChatMessage, error> clientStream) {
        log:printInfo(string `${caller.getId()} connected to chat`);
        consMap[caller.getId().toString()] = <@untainted>caller;
        //Read and process each message in the client stream
        error? e = clientStream.forEach(function(ChatMessage chatMsg) {
            grpc:Caller ep;
            string msg = string `${chatMsg.name}: ${chatMsg.message}`;
            log:printInfo("Server received message: " + msg);
            foreach var [callerId, connection] in consMap.entries() {
                ep = connection;
                grpc:Error? err = ep->send(msg);
                if (err is grpc:Error) {
                    log:printError("Error from Connector: " + err.message());
                } else {
                    log:printInfo("Server message to caller " + callerId
                                                        + " sent successfully.");
                }
            }
        });
        //Once the client sends a notification to indicate the end of the stream, 'grpc:EOS' is returned by the stream
        if (e is grpc:EOS) {
            string msg = string `${caller.getId()} left the chat`;
            log:printInfo(msg);
            var v = consMap.remove(caller.getId().toString());
            foreach var [callerId, connection] in consMap.entries() {
                grpc:Caller ep = connection;
                grpc:Error? err = ep->send(msg);
                if (err is grpc:Error) {
                    log:printError("Error from Connector: " + err.message());
                } else {
                    log:printInfo("Server message to caller " + callerId
                                                        + " sent successfully.");
                }
            }
        //If the client sends an error to the server, the stream closes and returns the error
        } else if (e is error) {
            log:printError("Error from Connector: " + e.message());
        }

    }
}
