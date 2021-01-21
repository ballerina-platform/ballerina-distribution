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

listener tcp:Listener echoServer = new tcp:Listener(PORT1);
listener tcp:Listener discardServer = new tcp:Listener(PORT2);
listener tcp:Listener closeServer = new tcp:Listener(PORT3);

service on echoServer {

    remote function onConnect(tcp:Caller caller) returns tcp:ConnectionService {
        io:println("Client connected to echoServer: ", caller.remotePort);
        return new EchoService(caller);
    }
}

service class EchoService {
    tcp:Caller caller;

    public function init(tcp:Caller c) {self.caller = c;}

    remote function onBytes(readonly & byte[] data) returns (readonly & byte[])|tcp:Error? {
        io:println("Echo: ", getString(data));
        return data;
    }

    remote function onError(readonly & tcp:Error err) returns tcp:Error? {
        io:println(err.message());
    }

    remote function onClose() returns tcp:Error? {
        io:println("invoke on close");
    }
}


service on discardServer {

    remote function onConnect(tcp:Caller caller) returns tcp:ConnectionService {
        io:println("Client connected to discardServer: ", caller.remotePort);
        return new DiscardService(caller);
    }
}

service class DiscardService {
    tcp:Caller caller;

    public function init(tcp:Caller c) {self.caller = c;}

    remote function onBytes(readonly & byte[] data) returns tcp:Error? {
        // read and discard the message
        io:println("Discard: ", getString(data));
    }

    remote function onError(readonly & tcp:Error err) returns tcp:Error? {
        io:println(err.message());
    }

    remote function onClose() returns tcp:Error? {}
}

service on closeServer {
    remote function onConnect(tcp:Caller caller) returns tcp:ConnectionService|tcp:Error {
        io:println("Client connected to closeServer: ", caller.remotePort);
        check caller->close();
        return new EchoService(caller);
    }
}

service class closeService {
    tcp:Caller caller;

    public function init(tcp:Caller c) {self.caller = c;}

}
