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

import ballerina/log;
import ballerina/test;
import ballerina/udp;
import ballerina/io;

const int PORT1 = 9001;

map<string> QuestionBank = {
    "hi": "hi there!",
    "who are you?": "I'm a ballerina bot"
};

service on new udp:Lisetener(PORT1) {

    remote function onDatagram(udp:Datagram datagram, udp:Caller caller) returns udp:Error? {
        string|error? dataString = getString(datagram.data);
        io:println("Received data: ", dataString);
        if (dataString is string && QuestionBank.hasKey(dataString)) {
            string? response = QuestionBank[dataString];
            if (response is string) {
                udp:Error? res = caller->sendDatagram(prepareDatagram(response, <string>caller.remoteHost,
                    <int>caller.remotePort));
            }
        }
        udp:Error? res = caller->sendDatagram(prepareDatagram("Sorry,I Can’t help you with that",
        <string>caller.remoteHost, <int>caller.remotePort));
    }

    remote function onError(readonly & udp:Error err) {
        log:print(err.message());
    }
}
