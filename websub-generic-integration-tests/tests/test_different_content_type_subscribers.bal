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

import ballerina/mime;
import ballerina/test;
import ballerina/lang.runtime as runtime;
import ballerina/http;
import ballerina/websub;

listener websub:Listener websubDifContentTypeEP = new websub:Listener(23282);

@websub:SubscriberServiceConfig {
    target: ["http://localhost:23191/websub/hub", "http://one.websub.topic.com"],
    leaseSeconds: 3000,
    secret: "Kslk30SNF2AChs2"
}
service websub:SubscriberService /websub on websubDifContentTypeEP {
    remote function onNotification (websub:Notification notification) {
        if (notification.getContentType() == mime:TEXT_PLAIN) {
            var payload = notification.getTextPayload();
            if (payload is string) {
                storeOutput(ID_TEXT_SUBSCRIBER_ONE, "Text WebSub Notification Received by websubSubscriber: " + <@untainted>payload);
            } else {
                panic payload;
            }
        } else if (notification.getContentType() == mime:APPLICATION_XML) {
            var payload = notification.getXmlPayload();
            if (payload is xml) {
                storeOutput(ID_XML_SUBSCRIBER_ONE, "XML WebSub Notification Received by websubSubscriber: " + <@untainted>payload.toString());
            } else {
                panic payload;
            }
        } else if (notification.getContentType() == mime:APPLICATION_JSON) {
            var payload = notification.getJsonPayload();
            if (payload is json) {
                storeOutput(ID_JSON_SUBSCRIBER_ONE, "JSON WebSub Notification Received by websubSubscriber: " + <@untainted>payload.toJsonString());
            } else {
                panic payload;
            }
        }
    }
}

@websub:SubscriberServiceConfig {
    path:"/websubTwo",
    subscribeOnStartUp:true,
    target: ["http://localhost:23191/websub/hub", "http://one.websub.topic.com"],
    leaseSeconds: 1000
}
service websub:SubscriberService /websubTwo on websubDifContentTypeEP {
    remote function onNotification (websub:Notification notification) {
        if (notification.getContentType() == mime:TEXT_PLAIN) {
            var payload = notification.getTextPayload();
            if (payload is string) {
                storeOutput(ID_TEXT_SUBSCRIBER_TWO, "Text WebSub Notification Received by websubSubscriberTwo: " + <@untainted>payload);
            } else {
                panic payload;
            }
        } else if (notification.getContentType() == mime:APPLICATION_XML) {
            var payload = notification.getXmlPayload();
            if (payload is xml) {
                storeOutput(ID_XML_SUBSCRIBER_TWO, "XML WebSub Notification Received by websubSubscriberTwo: " + <@untainted>payload.toString());
            } else {
                panic payload;
            }
        } else if (notification.getContentType() == mime:APPLICATION_JSON) {
            var payload = notification.getJsonPayload();
            if (payload is json) {
                storeOutput(ID_JSON_SUBSCRIBER_TWO, "JSON WebSub Notification Received by websubSubscriberTwo: " + <@untainted>payload.toJsonString());
            } else {
                panic payload;
            }
        }
    }
}

@test:Config {
    dependsOn: [testUnsubscription]
}
function testTextContentReceiptForInternalHub() {
    sendSubscriptionAndIntentVerificationRequest(COMMON_PATH + "23282", HUB_MODE_INTERNAL, TYPE_STRING);
    runtime:sleep(5);
    test:assertEquals(fetchOutput(ID_TEXT_SUBSCRIBER_ONE), TEXT_INTERNAL_HUB_NOTIFICATION_SUBSCRIBER_ONE_LOG);
    test:assertEquals(fetchOutput(ID_TEXT_SUBSCRIBER_TWO), TEXT_INTERNAL_HUB_NOTIFICATION_SUBSCRIBER_TWO_LOG);
}

@test:Config {
    dependsOn: [testTextContentReceiptForInternalHub]
}
function testTextContentReceiptForRemoteHub() {
    sendSubscriptionAndIntentVerificationRequest(COMMON_PATH + SKIP_SUBSCRIBER_CHECK, HUB_MODE_REMOTE, TYPE_STRING);
    runtime:sleep(5);
    test:assertEquals(fetchOutput(ID_TEXT_SUBSCRIBER_ONE), TEXT_REMOTE_HUB_NOTIFICATION_SUBSCRIBER_ONE_LOG);
    test:assertEquals(fetchOutput(ID_TEXT_SUBSCRIBER_TWO), TEXT_REMOTE_HUB_NOTIFICATION_SUBSCRIBER_TWO_LOG);
}

@test:Config {
    dependsOn: [testTextContentReceiptForRemoteHub]
}
function testXmlContentReceiptForInternalHub() {
    sendSubscriptionAndIntentVerificationRequest(COMMON_PATH + SKIP_SUBSCRIBER_CHECK, HUB_MODE_INTERNAL, TYPE_XML);
    runtime:sleep(5);
    test:assertEquals(fetchOutput(ID_XML_SUBSCRIBER_ONE), XML_INTERNAL_HUB_NOTIFICATION_SUBSCRIBER_ONE_LOG);
    test:assertEquals(fetchOutput(ID_XML_SUBSCRIBER_TWO), XML_INTERNAL_HUB_NOTIFICATION_SUBSCRIBER_TWO_LOG);
}

@test:Config {
    dependsOn: [testXmlContentReceiptForInternalHub]
}
function testXmlContentReceiptForRemoteHub() {
    sendSubscriptionAndIntentVerificationRequest(COMMON_PATH + SKIP_SUBSCRIBER_CHECK, HUB_MODE_REMOTE, TYPE_XML);
    runtime:sleep(5);
    test:assertEquals(fetchOutput(ID_XML_SUBSCRIBER_ONE), XML_REMOTE_HUB_NOTIFICATION_SUBSCRIBER_ONE_LOG);
    test:assertEquals(fetchOutput(ID_XML_SUBSCRIBER_TWO), XML_REMOTE_HUB_NOTIFICATION_SUBSCRIBER_TWO_LOG);
}

@test:Config {
    dependsOn: [testXmlContentReceiptForRemoteHub]
}
function testJsonContentReceiptForInternalHub() {
    sendSubscriptionAndIntentVerificationRequest(COMMON_PATH + SKIP_SUBSCRIBER_CHECK, HUB_MODE_INTERNAL, TYPE_JSON);
    runtime:sleep(10);
    test:assertEquals(fetchOutput(ID_JSON_SUBSCRIBER_ONE), JSON_INTERNAL_HUB_NOTIFICATION_SUBSCRIBER_ONE_LOG);
    test:assertEquals(fetchOutput(ID_JSON_SUBSCRIBER_TWO), JSON_INTERNAL_HUB_NOTIFICATION_SUBSCRIBER_TWO_LOG);
}

@test:Config {
    dependsOn: [testJsonContentReceiptForInternalHub]
}
function testJsonContentReceiptForRemoteHub() {
    sendSubscriptionAndIntentVerificationRequest(COMMON_PATH + SKIP_SUBSCRIBER_CHECK, HUB_MODE_REMOTE, TYPE_JSON);
    runtime:sleep(10);
    test:assertEquals(fetchOutput(ID_JSON_SUBSCRIBER_ONE), JSON_REMOTE_HUB_NOTIFICATION_SUBSCRIBER_ONE_LOG);
    test:assertEquals(fetchOutput(ID_JSON_SUBSCRIBER_TWO), JSON_REMOTE_HUB_NOTIFICATION_SUBSCRIBER_TWO_LOG);
}

function sendSubscriptionAndIntentVerificationRequest (string path, string mode, string contentType) {
    http:Client clientEndpoint = new ("http://localhost:23080");
    json jsonPayload = {mode: mode, content_type: contentType};
    http:Request req = new;
    req.addHeader(http:CONTENT_TYPE, CONTENT_TYPE_JSON);
    req.setJsonPayload(jsonPayload);
    var response = clientEndpoint->post(path, req);
}
