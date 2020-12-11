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

import ballerina/io;
import ballerina/http;
import ballerina/runtime;
import ballerina/stringutils;
import ballerina/test;
import ballerina/websub;

listener websub:Listener websubEP = new websub:Listener(23181, { host: "0.0.0.0" });

@websub:SubscriberServiceConfig {
    //path:"/websub",
    subscribeOnStartUp:true,
    target: ["http://localhost:23191/websub/hub", "http://one.websub.topic.com"]
}
service websub:SubscriberService /websub on websubEP {
    remote function onNotification (websub:Notification notification) {
        json payload = <json> notification.getJsonPayload();
        storeOutput(ID_HUB_NOTIFICATION_LOG, "WebSub Notification Received: " + <@untainted>payload.toJsonString());
        io:println("WebSub Notification Received: " + <@untainted>payload.toJsonString());
    }
}

@websub:SubscriberServiceConfig {
    target: ["http://localhost:23191/websub/hub", "http://one.websub.topic.com"],
    leaseSeconds: 3650,
    secret: "Kslk30SNF2AChs2"
}
service websub:SubscriberService /subscriberWithNoPathInAnnot on websubEP {
    remote function onIntentVerification (websub:Caller caller, websub:IntentVerificationRequest request) {
        http:Response response = request.buildSubscriptionVerificationResponse("http://one.websub.topic.com");
        if (response.statusCode == 202) {
            storeOutput(ID_EXPLICIT_INTENT_VERIFICATION_LOG, "Intent verified explicitly for subscription change request");
        } else {
            io:println("Intent verification denied explicitly for subscription change request");
        }
        var result = caller->respond(<@untainted> response);
        if (result is error) {
            io:println("Error responding to intent verification request: ", result);
        }
    }

    remote function onNotification (websub:Notification notification) {
        string payload = <string> notification.getTextPayload();
        storeOutput(ID_HUB_NOTIFICATION_LOG_TWO, "WebSub Notification Received by Two: " + <@untainted>payload);
        io:println("WebSub Notification Received by Two: " + <@untainted>payload);
    }
}

string subscriberThreeTopic = "http://one.websub.topic.com";

@websub:SubscriberServiceConfig {
    path:"/websubThree",
    subscribeOnStartUp:true,
    target: ["http://localhost:23191/websub/hub", subscriberThreeTopic],
    leaseSeconds: 300,
    callback: "http://localhost:23181/websubThree?topic=" + subscriberThreeTopic + "&fooVal=barVal",
    secret: "Xaskdnfe234"
}
service websub:SubscriberService /websubThree on websubEP {
    remote function onNotification (websub:Notification notification) {
        string payload = <string> notification.getTextPayload();
        io:println("WebSub Notification Received by Three: ", payload);
        io:println("Query Params: ", notification.getQueryParams());
        storeOutput(ID_QUERY_PARAM_LOG, "Query Params: " + <@untainted>notification.getQueryParams().toString());
    }
}

@test:Config {}
function testSubscriptionAndAutomaticIntentVerification() {
    test:assertEquals(fetchOutput(ID_EXPLICIT_INTENT_VERIFICATION_LOG), EXPLICIT_INTENT_VERIFICATION_LOG);
}

@test:Config {
    dependsOn: ["testSubscriptionAndAutomaticIntentVerification"]
}
function testContentInternalHubNotification() {
    http:Client clientEndpoint = new ("http://localhost:23080");
    json jsonPayload = {mode: "internal", content_type: "json"};
    http:Request req = new;
    req.addHeader(http:CONTENT_TYPE, CONTENT_TYPE_JSON);
    req.setJsonPayload(jsonPayload);
    var response = clientEndpoint->post("/publisher/notify/23181", req);
    //var response = clientEndpoint->post("/publisher/notify", req);
    runtime:sleep(5000);

    test:assertEquals(fetchOutput(ID_HUB_NOTIFICATION_LOG), INTERNAL_HUB_NOTIFICATION_LOG);
    test:assertEquals(fetchOutput(ID_HUB_NOTIFICATION_LOG_TWO), INTERNAL_HUB_NOTIFICATION_LOG_TWO);
}

@test:Config {
    dependsOn: ["testContentInternalHubNotification"]
}
function testContentRemoteHubNotification() {
    http:Client clientEndpoint = new ("http://localhost:23080");
    json jsonPayload = {mode: "remote", content_type: "json"};
    http:Request req = new;
    req.addHeader(http:CONTENT_TYPE, CONTENT_TYPE_JSON);
    req.setJsonPayload(jsonPayload);
    var response = clientEndpoint->post("/publisher/notify/23181", req);
    runtime:sleep(5000);

    test:assertEquals(fetchOutput(ID_HUB_NOTIFICATION_LOG), REMOTE_HUB_NOTIFICATION_LOG);
    test:assertEquals(fetchOutput(ID_HUB_NOTIFICATION_LOG_TWO), REMOTE_HUB_NOTIFICATION_LOG_TWO);
}

@test:Config {
    dependsOn: ["testContentRemoteHubNotification"]
}
function testContentReceiptForCallbackWithQueryParams() {
    test:assertEquals(fetchOutput(ID_QUERY_PARAM_LOG), QUERY_PARAM_LOG);
}

@test:Config {
    dependsOn: ["testContentReceiptForCallbackWithQueryParams"]
}
function testRemoteTopicRegistration() {
    http:Client clientEndpoint = new ("http://localhost:23191");
    http:Request req = new;
    req.setPayload("hub.mode=subscribe&hub.topic=http%3A//two.websub.topic.com&hub.callback=http%3A//localhost%3A23181/websub");
    var s = req.setContentType(CONTENT_TYPE_FORM_URL_ENCODED);
    req.addHeader(http:CONTENT_TYPE, "application/x-www-form-urlencoded");
    var response = clientEndpoint->post("/websub/hub", req);
    if (response is http:Response) {
        test:assertEquals(response.statusCode, http:STATUS_ACCEPTED, msg = "Response code mismatched");
    } else {
       test:assertFail(msg = "Unexpected response");
    }
}

@test:Config {
    dependsOn: ["testRemoteTopicRegistration"]
}
function testSubscriberDetailsRetrievalFromHub() {
    http:Client clientEndpoint = new ("http://localhost:23080");
    http:Request req = new;
    req.setHeader("x-topic", "http://one.websub.topic.com");
    req.setHeader(http:CONTENT_TYPE, CONTENT_TYPE_JSON);
    var response = clientEndpoint->get("/publisher/topicInfo", req);
    HttpResponseDetails httpResponseDetails = fetchHttpResponse(response);
    test:assertEquals(httpResponseDetails.statusCode, http:STATUS_OK);
    test:assertTrue(stringutils:contains(httpResponseDetails.responseMessage, "\"callback\":\"http://localhost:23181/websub\""));
    test:assertTrue(
        stringutils:contains(httpResponseDetails.responseMessage,
        "\"callback\":\"http://localhost:23181/subscriberWithNoPathInAnnot\"")
    );
    test:assertTrue(
        stringutils:contains(httpResponseDetails.responseMessage,
        "\"callback\":\"http://localhost:23181/websubThree?topic=http://one.websub.topic.com&fooVal=barVal\"")
    );
}

@test:Config {
    dependsOn: ["testSubscriberDetailsRetrievalFromHub"]
}
function testAvailableTopicsRetrievalFromHub() {
    http:Client clientEndpoint = new ("http://localhost:23080");
    http:Request req = new;
    var response = clientEndpoint->get("/publisher/topicInfo", req);

    HttpResponseDetails httpResponseDetails = fetchHttpResponse(response);
    io:println(httpResponseDetails);
    string expectedData = "{\"Topic_1\":\"http://one.websub.topic.com\", " +
                           "\"Topic_2\":\"http://three.websub.topic.com\", \"Topic_3\":\"http://four.websub.topic.com\", " +
                           "\"Topic_4\":\"http://one.redir.topic.com\", \"Topic_5\":\"http://two.redir.topic.com\", " +
                           "\"Topic_6\":\"http://two.websub.topic.com\"}";
    test:assertEquals(httpResponseDetails.statusCode, http:STATUS_OK);
    test:assertEquals(httpResponseDetails.responseMessage, expectedData);
}

@test:Config {
    before: "sendUnsubscription",
    dependsOn: ["testAvailableTopicsRetrievalFromHub"]
}
function testUnsubscription() {
    http:Client clientEndpoint = new ("http://localhost:23080");
    var response = clientEndpoint->get("/publisher/unsubscribe");
    HttpResponseDetails responseDetails = fetchHttpResponse(response);
    test:assertEquals(responseDetails.responseMessage, "unsubscription successful", msg = "Mismatched");

    json jsonPayload = {mode: "internal", content_type: "json"};
    http:Request req = new;
    req.addHeader(http:CONTENT_TYPE, CONTENT_TYPE_JSON);
    req.setJsonPayload(jsonPayload);
    var postResponse = clientEndpoint->post("/publisher/notify/skip_subscriber_check", req);
    runtime:sleep(5000);
    if (postResponse is http:Response) {
        test:assertEquals(postResponse.statusCode, http:STATUS_ACCEPTED, msg = "Response code mismatched");
    } else {
        test:assertFail(msg = "Unexpected response");
    }

}

