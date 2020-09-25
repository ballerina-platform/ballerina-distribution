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
import ballerina/runtime;
import ballerina/system;
import ballerina/test;
import ballerinax/rabbitmq;

const QUEUE_SYNC = "MyQueueSync";

@test:Config {}
public function testSyncConsumer() {
    log:printInfo("Starting RabbitMQ Docker Container.");
    var dockerStartResult = system:exec("docker", {}, "/", "run", "-d", "--name", "rabbit-tests", "-p", "15672:15672",
        "-p", "5672:5672", "rabbitmq:3-management");
    runtime:sleep(20000);
    rabbitmq:Connection newConnection = new ({host: "0.0.0.0", port: 5672});
    rabbitmq:Channel newChannel = new (newConnection);
    string? queue = checkpanic newChannel->queueDeclare({queueName: QUEUE_SYNC});
    rabbitmq:Error? producerResult = newChannel->basicPublish("Testing Sync Consumer", QUEUE_SYNC);
    rabbitmq:Message|rabbitmq:Error getResult = newChannel->basicGet(QUEUE_SYNC, rabbitmq:AUTO_ACK);
    if (getResult is rabbitmq:Error) {
        test:assertFail("Pulling a message from the broker caused an error.");
    } else {
        string messageReceived = checkpanic getResult.getTextContent();
        test:assertEquals(messageReceived, "Testing Sync Consumer", msg = "Message received does not match.");
    }
}
