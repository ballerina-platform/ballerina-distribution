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

import ballerina/filepath;
import ballerina/io;
import ballerina/runtime;
import ballerina/test;
import ballerinax/kafka;

const TEST_PATH = "src/kafka/tests/";
const DOCKER_COMPOSE_FILE = "docker-compose.yaml";
const TEST_MESSAGE = "Hello, Ballerina";
const TEST_DIRECTORY = "";

string topic = "test-topic";
string receivedMessage = "";

kafka:ProducerConfiguration producerConfiguration = {
    bootstrapServers: "localhost:9092",
    clientId: "basic-producer",
    acks: kafka:ACKS_ALL,
    maxBlockInMillis: 6000,
    requestTimeoutInMillis: 2000,
    valueSerializerType: kafka:SER_STRING,
    retryCount: 3
};
kafka:Producer producer = new (producerConfiguration);

@test:Config {}
function consumerServiceTest() returns error? {
    check startKafkaServerForConsumerTests();
    check sendMessage(TEST_MESSAGE, topic);
    kafka:ConsumerConfiguration consumerConfiguration = {
        bootstrapServers: "localhost:9092",
        topics: [topic],
        offsetReset: kafka:OFFSET_RESET_EARLIEST,
        groupId: "consumer-service-test-group",
        valueDeserializerType: kafka:DES_STRING,
        clientId: "test-consumer-1"
    };
    kafka:Consumer consumer = new (consumerConfiguration);
    var attachResult = check consumer.__attach(consumerService);
    var startResult = check consumer.__start();

    runtime:sleep(5000);
    test:assertEquals(receivedMessage, TEST_MESSAGE);
    check stopKafkaServerForConsumerTests();
}

function sendMessage(string message, string topic) returns error? {
    return producer->send(message, topic);
}

service consumerService =
service {
    resource function onMessage(kafka:Consumer consumer, kafka:ConsumerRecord[] records) {
        foreach var kafkaRecord in records {
            var value = kafkaRecord.value;
            if (value is string) {
                receivedMessage = <@untainted>value;
            }
        }
    }
};

function startKafkaServerForConsumerTests() returns error? {
    string parentDirectory = check getAbsoluteTestPath(TEST_DIRECTORY);
    var result = createKafkaCluster(parentDirectory, DOCKER_COMPOSE_FILE);
    if (result is error) {
        io:println(result);
        return result;
    }
}

function stopKafkaServerForConsumerTests() returns error? {
    string parentDirectory = check getAbsoluteTestPath(TEST_DIRECTORY);
    var result = stopKafkaCluster(parentDirectory, DOCKER_COMPOSE_FILE);
    if (result is error) {
        io:println(result);
        return result;
    }
}

function getAbsoluteTestPath(string subdirectoryPath) returns string|error {
    var relativePathResult = filepath:build(TEST_PATH, subdirectoryPath);
    if (relativePathResult is error) {
        return relativePathResult;
    }
    string relativePath = <string>relativePathResult;
    return filepath:absolute(relativePath);
}
