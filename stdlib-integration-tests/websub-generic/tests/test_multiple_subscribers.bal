// Copyright (c) 2018 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

import ballerina/http;
import ballerina/test;
import ballerina/lang.runtime as runtime;
import ballerina/websub;

listener websub:Listener multipleSubTestWebsubEP = new websub:Listener(23383);

// Following listner has no services attached with and it should not fail the listener start
listener websub:Listener websubEndPointWithNoAttachedServices = new websub:Listener(23384);

@websub:SubscriberServiceConfig {
    target: ["http://localhost:23191/websub/hub", "http://three.websub.topic.com"],
    leaseSeconds: 3600,
    secret: "Kslk30SNF2AChs2"
}
service websub:SubscriberService /websub on multipleSubTestWebsubEP {
    remote function onNotification (websub:Notification notification) {
        var payload = notification.getJsonPayload();
        if (payload is json) {
            storeOutput(ID_INTERNAL_HUB_NOTIFICATION_SUBSCRIBER_ONE_LOG, "WebSub Notification Received by One: " + <@untainted>payload.toJsonString());
        } else {
            panic payload;
        }
    }
}

@websub:SubscriberServiceConfig {
    target: "http://localhost:23080/publisherTwo/discover",
    leaseSeconds: 1200,
    secret: "SwklSSf42DLA"
}
service websub:SubscriberService /websubTwo on multipleSubTestWebsubEP {
    remote function onNotification (websub:Notification notification) {
        var payload = notification.getJsonPayload();
        if (payload is json) {
            storeOutput(ID_INTERNAL_HUB_NOTIFICATION_SUBSCRIBER_TWO_LOG, "WebSub Notification Received by Two: " + <@untainted>payload.toJsonString());
        } else {
            panic payload;
        }
    }
}

@test:Config {
    dependsOn: [testJsonContentReceiptForRemoteHub],
    enable: false
}
function testContentReceipt() {
    http:Client clientEndpoint = new ("http://localhost:23080");
    json jsonPayload = {mode: "internal", content_type: "json"};
    http:Request req = new;
    req.addHeader(http:CONTENT_TYPE, CONTENT_TYPE_JSON);
    req.setJsonPayload(jsonPayload);

    var response = clientEndpoint->post("/publisherTwo/notify", req);
    runtime:sleep(5);
    test:assertEquals(fetchOutput(ID_INTERNAL_HUB_NOTIFICATION_SUBSCRIBER_ONE_LOG), INTERNAL_HUB_NOTIFICATION_SUBSCRIBER_ONE_LOG);
    test:assertEquals(fetchOutput(ID_INTERNAL_HUB_NOTIFICATION_SUBSCRIBER_TWO_LOG), INTERNAL_HUB_NOTIFICATION_SUBSCRIBER_TWO_LOG);
}
