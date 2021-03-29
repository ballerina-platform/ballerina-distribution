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

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR,
    descMap: getDescriptorMap()
}
service "HelloWorld" on new grpc:Listener(20005) {

    isolated function lotsOfGreetings(stream<string,error> clientStream) returns string|error {
        log:printInfo("Client connected successfully.");
        // Read and process each message in the client stream.
        error? e = clientStream.forEach(isolated function(string name) {
            log:printInfo("Greet received: " + name);
        });
        // Once the client sends a notification to indicate the end of the stream, '()' is returned by the stream.
        if (e is ()) {
            return "Ack";
        } else {
            //If the client sends an error to the server, the stream closes and returns the error
            log:printError("Connection is closed by the client with Error", 'error = e);
            return "";
        }
    }
}
