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

// Bind the `service` to the port.
@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR,
    descMap: getDescriptorMap()
}
service HelloWorld on new grpc:Listener(20002) {

    isolated resource function hello(grpc:Caller caller, string name) {
        log:print("Server received hello from " + name);
        string message = "Hello " + name;

        // Send a response message to the caller.
        grpc:Error? result = caller->send(message);
        if (result is grpc:Error) {
            log:printError("Error from Connector: " + result.message());
        }
        // Send the `completed` notification to the caller.
        result = caller->complete();
        if (result is grpc:Error) {
            log:printError("Error from Connector: " + result.message());
        }
    }
}
