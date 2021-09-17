// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

import ballerina/io;
import ballerina/tcp;

const int PORT1 = 8809;
const int PORT2 = 8023;
const int PORT3 = 8639;
const int PORT4 = 8475;

string keyPath = "tests/resources/private.key";
string certPath = "tests/resources/public.crt";

listener tcp:Listener echoServer = new tcp:Listener(PORT1);
listener tcp:Listener discardServer = new tcp:Listener(PORT2);
listener tcp:Listener closeServer = new tcp:Listener(PORT3);

service on echoServer {

    isolated remote function onConnect(tcp:Caller caller) returns tcp:ConnectionService {
        io:println("Client connected to echoServer: ", caller.remotePort);
        return new EchoService();
    }
}

service class EchoService {

    remote function onBytes(tcp:Caller caller, readonly & byte[] data) returns tcp:Error? {
        io:println("Echo: ", 'string:fromBytes(data));
        check caller->writeBytes(data);
    }

    isolated remote function onError(tcp:Error err) returns tcp:Error? {
        io:println(err.message());
    }

    isolated remote function onClose() returns tcp:Error? {
        io:println("invoke on close");
    }
}


service on discardServer {

    isolated remote function onConnect(tcp:Caller caller) returns tcp:ConnectionService {
        io:println("Client connected to discardServer: ", caller.remotePort);
        return new DiscardService();
    }
}

service class DiscardService {

    remote function onBytes(readonly & byte[] data) returns tcp:Error? {
        // read and discard the message
        io:println("Discard: ", 'string:fromBytes(data));
    }
}

service on closeServer {
    isolated remote function onConnect(tcp:Caller caller) returns tcp:Error? {
        io:println("Client connected to closeServer: ", caller.remotePort);
        check caller->close();
    }
}

service on new tcp:Listener(PORT4, secureSocket = {
    key: {
        certFile: certPath,
        keyFile: keyPath
    },
    protocol: {
        name: tcp:TLS,
        versions: ["TLSv1.2", "TLSv1.1"]
    },
    ciphers: ["TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA"],
    handshakeTimeout: 10
}, localHost = "localhost") {

    isolated remote function onConnect(tcp:Caller caller) returns tcp:ConnectionService {
        io:println("Client connected to secureEchoServer: ", caller.remotePort);
        return new SecureEchoService();
    }
}

service class SecureEchoService {

    remote function onBytes(readonly & byte[] data) returns byte[] {
        io:println("Echo: ", 'string:fromBytes(data));
        return data;
    }

    isolated remote function onError(tcp:Error err) returns tcp:Error? {
        io:println(err.message());
    }
}
