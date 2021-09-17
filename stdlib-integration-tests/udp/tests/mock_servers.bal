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
import ballerina/udp;

const int PORT1 = 9001;

map<string> QuestionBank = {
    "hi": "hi there!",
    "who are you?": "I'm a ballerina bot"
};

service on new udp:Listener(PORT1) {

 remote function onDatagram(readonly & udp:Datagram datagram, udp:Caller caller ) 
        returns udp:Error|udp:Datagram? {
            string|error request = string:fromBytes(datagram.data);
        if (request is string && QuestionBank.hasKey(request)) {
            udp:Datagram|error response = datagram.cloneWithType(udp:Datagram);
            if (response is error) {
                return datagram;
            } else {
                response.data = QuestionBank.get(request).toBytes();
                check caller->sendDatagram(response);
            }   
        } else {
            return datagram;
        }
    }

    remote function onError(udp:Error err) {
        log:printError("An error occurred", 'error = err);
    }
}
