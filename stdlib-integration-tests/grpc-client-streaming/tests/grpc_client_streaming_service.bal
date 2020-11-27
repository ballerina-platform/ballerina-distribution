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
service HelloWorld on new grpc:Listener(20005) {

    isolated resource function lotsOfGreetings(grpc:Caller caller,
                            stream<string,error> clientStream) {
        log:printInfo("Client connected sucessfully.");
        //Read and process each message in the client stream
        error? e = clientStream.forEach(isolated function(string name) {
            log:printInfo("Server received greet: " + name);
        });

        //Once the client sends a notification to indicate the end of the stream, 'grpc:EOS' is returned by the stream
        if (e is grpc:EOS) {
            grpc:Error? err = caller->send("Ack");
            if (err is grpc:Error) {
                log:printError("Error from Connector: " + err.message());
            } else {
                log:printInfo("Server send response : Ack");
            }

        //If the client sends an error to the server, the stream closes and returns the error
        } else if (e is error) {
            log:printError("Error from Connector: " + e.message());
        }
    }
}
