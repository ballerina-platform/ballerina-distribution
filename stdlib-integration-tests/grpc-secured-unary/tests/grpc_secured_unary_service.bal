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

// Server endpoint configuration with the SSL configurations.
listener grpc:Listener ep = new (20004, {
    host: "localhost",
    secureSocket: {
        keyStore: {
            path: KEYSTORE_PATH,
            password: "ballerina"
        }
    }
});

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR,
    descMap: getDescriptorMap()
}
service HelloWorld on ep {
    isolated resource function hello(grpc:Caller caller, string name) {
        log:printInfo("Server received hello from " + name);
        string message = "Hello " + name;

        // Send a response message to the caller.
        grpc:Error? err = caller->send(message);

        if (err is grpc:Error) {
            log:printError("Error from Connector: " + err.message());
        } else {
            log:printInfo("Server send response : " + message);
        }

        // Send the `completed` notification to the caller.
        grpc:Error? result = caller->complete();
        if (result is grpc:Error) {
            log:printError("Error in sending completed notification to caller",
                err = result);
        }
    }
}
