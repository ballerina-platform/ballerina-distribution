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

// This is the server implementation of the bidirectional streaming scenario.
import ballerina/grpc;
import ballerina/log;

listener grpc:Listener ep = check new (9090);

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR,
    descMap: getDescriptorMap()
}
service "Chat" on ep {
    remote function chat(stream<ChatMessage, grpc:Error?> clientStream)
                            returns stream<string, grpc:Error?> {
        log:printInfo("Invoke the chat RPC");
        // Read and process each message in the client stream and return.
        return from var chatMsg in clientStream
                 let var r = string `${chatMsg.message}: ${chatMsg.name}`
                 select r;
    }
}
