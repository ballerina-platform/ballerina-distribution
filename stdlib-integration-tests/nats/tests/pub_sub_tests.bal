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
// KIND, either express or implied. See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/log;
import ballerina/runtime;
import ballerina/system;
import ballerina/test;
import ballerinax/nats;

const SERVICE_SUBJECT_NAME = "nats-basic-service";
string receivedConsumerMessage = "";

@test:Config {}
public function testConsumerService() {
    startDockerContainer();
    nats:Connection con = new(["nats://localhost:4222"]);
    string message = "Testing Consumer Service";
    nats:Listener sub = new(con);
    nats:Producer producer = new(con);
    checkpanic sub.__attach(consumerService);
    checkpanic sub.__start();
    checkpanic producer->publish(SERVICE_SUBJECT_NAME, message);
    runtime:sleep(5000);
    test:assertEquals(receivedConsumerMessage, message, msg = "Message received does not match.");
}

service consumerService =
@nats:SubscriptionConfig {
    subject: SERVICE_SUBJECT_NAME
}
service {
    resource function onMessage(nats:Message msg, string data) {
        receivedConsumerMessage = <@untainted> data;
        log:printInfo("Message Received: " + receivedConsumerMessage);
    }

    resource function onError(nats:Message msg, Error err) {
    }
};

function startDockerContainer() {
    log:printInfo("Starting NATS Docker Container.");
    var dockerStartResult = system:exec("docker", {}, "/", "run", "-d", "--name", "nats-tests", "-p", "4222:4222",
        "nats:latest");
    runtime:sleep(10000);
}
