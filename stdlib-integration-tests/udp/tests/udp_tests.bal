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
import ballerina/log;
import ballerina/test;
import ballerina/udp;

//test to check existance of udp module
@test:Config {}
function testUdp() {
    udp:Client|udp:Error? socketClient = new ("localhost", 2000);
    if (socketClient is udp:Client) {
        string msg = "Hello Ballerina echo";
        udp:Datagram datagram = {
            remoteAddress: {
                host: "localhost",
                port: 48829
            },
            data: msg.toBytes()
        };

        var sendResult = socketClient->send(datagram);
        if (sendResult is ()) {
            log:print("Datagram was sent to the remote host.");
        } else {
            test:assertFail(msg = sendResult.message());
        }
    }
    checkpanic socketClient->close();
}
