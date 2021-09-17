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

import ballerina/io;
import ballerina/http;
import ballerina/websubhub;
import ballerina/test;

public function startHub() returns string {
    io:println("Starting up the Ballerina Hub Service");
    string resultString = "";
    websubhub:Hub webSubHub;

    var result = websubhub:startHub(new http:Listener(9191), "/websub", "/hub");
    if (result is websubhub:Hub) {
        webSubHub = result;
    } else if (result is websubhub:HubStartedUpError) {
        webSubHub = result.startedUpHub;
    } else {
        resultString = result.message();
        io:println("Hub start error:" + result.message());
        return resultString;
    }
    var registrationResponse = webSubHub.registerTopic("http://websubpubtopic.com");
    if (registrationResponse is error) {
        resultString = resultString + registrationResponse.message();
        io:println("Error occurred registering topic: " +
                                registrationResponse.message());
    } else {
        resultString = resultString + "Topic registration successful!";
        io:println("Topic registration successful!");
    }

    io:println("Publishing update to internal Hub");
    var publishResponse = webSubHub.publishUpdate("http://websubpubtopic.com",
        {"action": "publish", "mode": "internal-hub"});

    if (publishResponse is error) {
        resultString = resultString + publishResponse.message();
        io:println("Error notifying hub: " + publishResponse.message());
    } else {
        resultString = resultString + "Update notification successful!";
        io:println("Update notification successful!");
    }

    return resultString;
}

@test:Config{}
public function testStartHubAndPublish() {
    string result = startHub();
    io:println(result);
    test:assertEquals(result, "Topic registration successful!Update notification successful!",
                msg = "Error starting the hub");
}
