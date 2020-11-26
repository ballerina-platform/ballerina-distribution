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
service HelloWorld on new grpc:Listener(20003) {

    isolated resource function lotsOfReplies(grpc:Caller caller, string name) {
        log:printInfo("Server received hello from " + name);
        string[] greets = ["Hi", "Hey", "GM"];

        // Send multiple messages to the caller.
        foreach string greet in greets {
            string msg = greet + " " + name;
            grpc:Error? err = caller->send(msg);
            if (err is grpc:Error) {
                log:printError("Error from Connector: " + err.message());
            } else {
                log:printInfo("Send reply: " + msg);
            }
        }

        // Once all the messages are sent, the server notifies the caller with a `complete` message.
        grpc:Error? result = caller->complete();
        if (result is grpc:Error) {
            log:printError("Error in sending completed notification to caller",
                err = result);
        }
    }
}
