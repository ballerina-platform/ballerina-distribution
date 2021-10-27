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

import ballerina/test;
import ballerina/http;
import ballerina/websub;

public type CustomSubWebhookListenerConf record {
    string host = "";
};

public type CustomSubMockActionEvent record {|
    string action;
|};

public type CustomSubMockDomainEvent record {|
    string domain;
|};

@websub:SubscriberServiceConfig {}
service websub:SubscriberService /key on new CustomSubWebhookServerForPayload(23585) {
    remote function onIntentVerification(websub:Caller caller, websub:IntentVerificationRequest verRequest) {
        storeOutput(ID_INTENT_VER_REQ_RECEIVED_LOG, "Intent verification request received");
        checkpanic caller->accepted();
    }

    remote function onCreated(websub:Notification notification, CustomSubMockActionEvent event) {
        storeOutput(ID_BY_KEY_CREATED_LOG,  "Created Notification Received, action: " + <@untainted>event.action);
    }

    remote function onFeature(websub:Notification notification, CustomSubMockDomainEvent event) {
        storeOutput(ID_BY_KEY_FEATURE_LOG, "Feature Notification Received, domain: " +  <@untainted>event.domain);
    }

    remote function onStatus(websub:Notification notification, CustomSubMockActionEvent event) {
        // do nothing - test start up
    }
}

@websub:SubscriberServiceConfig {}
service websub:SubscriberService /header on new CustomSubWebhookServerForHeader(23686) {
    remote function onIssue(websub:Notification notification, CustomSubMockActionEvent event) {
        string msg = "Issue Notification Received, header value: " + <@untainted>notification.getHeader(CUSTOM_SUB_MOCK_HEADER) +
                                 " action: " +  <@untainted>event.action;
        storeOutput(ID_BY_HEADER_ISSUE_LOG, msg);
    }

    remote function onCommit(websub:Notification notification, CustomSubMockActionEvent event) {
        string msg = "Commit Notification Received, header value: " + <@untainted>notification.getHeader(CUSTOM_SUB_MOCK_HEADER) +
                                 " action: " + <@untainted>event.action;
        storeOutput(ID_BY_HEADER_COMMIT_LOG, msg);
    }

    remote function onStatus(websub:Notification notification, CustomSubMockActionEvent event) {
        // do nothing - test start up
    }
}

@websub:SubscriberServiceConfig {}
service websub:SubscriberService /headerAndPayload on new CustomSubWebhookServerForHeaderAndPayload(23787) {
    remote function onIssueCreated(websub:Notification notification, CustomSubMockActionEvent event) {
        string msg = "Issue Created Notification Received, header value: " + <@untainted>notification.getHeader(CUSTOM_SUB_MOCK_HEADER) +
            " action: " +  <@untainted>event.action;
        storeOutput(ID_BY_HEADER_AND_PAYLOAD_ISSUE_CREATED_LOG, msg);

    }

    remote function onFeaturePull(websub:Notification notification, CustomSubMockDomainEvent event) {
        string msg = "Feature Pull Notification Received, header value: " + <@untainted>notification.getHeader(CUSTOM_SUB_MOCK_HEADER) +
            " domain: " +  <@untainted>event.domain;
        storeOutput(ID_BY_HEADER_AND_PAYLOAD_FEATURE_PULL_LOG, msg);
    }

    remote function onHeaderOnly(websub:Notification notification, CustomSubMockActionEvent event) {
        string msg = "HeaderOnly Notification Received, header value: " + <@untainted>notification.getHeader(CUSTOM_SUB_MOCK_HEADER) +
            " action: " +  <@untainted>event.action;
        storeOutput(ID_BY_HEADER_AND_PAYLOAD_HEADER_ONLY_LOG, msg);
    }

    remote function onKeyOnly(websub:Notification notification, CustomSubMockActionEvent event) {
        string msg = "KeyOnly Notification Received, header value: " + <@untainted>notification.getHeader(CUSTOM_SUB_MOCK_HEADER) +
            " action: " +  <@untainted>event.action;
        storeOutput(ID_BY_HEADER_AND_PAYLOAD_KEY_ONLY_LOG, msg);
    }

    remote function onStatus(websub:Notification notification, CustomSubMockActionEvent event) {
        // do nothing - test start up
    }
}

/////////////////// Specific Webhook for dispatching by key ///////////////////
public class CustomSubWebhookServerForPayload {

    private websub:Listener websubListener;

    public function init(int port, CustomSubWebhookListenerConf? config = ()) {
        websub:ExtensionConfig extensionConfig = {
            topicIdentifier: websub:TOPIC_ID_PAYLOAD_KEY,
            payloadKeyResourceMap: {
                "action" : {
                    "created" : ["onCreated", CustomSubMockActionEvent],
                    "deleted" : ["onDeleted", CustomSubMockActionEvent],
                    "statuscheck" : ["onStatus", CustomSubMockActionEvent]
                },
                "domain" : {
                    "issue" : ["onIssue", CustomSubMockDomainEvent],
                    "feature" : ["onFeature", CustomSubMockDomainEvent]
                }
            }
        };
        string host = config is () ? "" : config.host;
        websub:SubscriberListenerConfiguration sseConfig = {
            host: host,
            extensionConfig: extensionConfig
        };
        self.websubListener = new(port, sseConfig);
    }

    public function attach(websub:SubscriberService s, string[]|string? name = ()) returns error? {
        return self.websubListener.attach(s, name);
    }

    public function detach(websub:SubscriberService s) returns error? {
        return self.websubListener.detach(s);
    }

    public function 'start() returns error? {
        return self.websubListener.'start();
    }

    public function gracefulStop() returns error? {
        return ();
    }

    public function immediateStop() returns error? {
        return self.websubListener.immediateStop();
    }
}

/////////////////// Specific Webhook for dispatching by header ///////////////////
public class CustomSubWebhookServerForHeader {

    private websub:Listener websubListener;

    public function init(int port, CustomSubWebhookListenerConf? config = ()) {
        websub:ExtensionConfig extensionConfig = {
            topicIdentifier: websub:TOPIC_ID_HEADER,
            topicHeader: CUSTOM_SUB_MOCK_HEADER,
            headerResourceMap: {
                "issue" : ["onIssue", CustomSubMockActionEvent],
                "commit" : ["onCommit", CustomSubMockActionEvent],
                "status" : ["onStatus", CustomSubMockActionEvent]
            }
        };
        string host = config is () ? "" : config.host;
        websub:SubscriberListenerConfiguration sseConfig = {
            host: host,
            extensionConfig: extensionConfig
        };
        self.websubListener = new(port, sseConfig);
    }

    public function attach(websub:SubscriberService s, string[]|string? name = ()) returns error? {
        return self.websubListener.attach(s, name);
    }

    public function detach(websub:SubscriberService s) returns error? {
        return self.websubListener.detach(s);
    }

    public function 'start() returns error? {
        return self.websubListener.'start();
    }

    public function gracefulStop() returns error? {
        return ();
    }

    public function immediateStop() returns error? {
        return self.websubListener.immediateStop();
    }
}

/////////////////// Specific Webhook for dispatching by header and payload ///////////////////
public class CustomSubWebhookServerForHeaderAndPayload {

    private websub:Listener websubListener;

    public function init(int port, CustomSubWebhookListenerConf? config = ()) {
        websub:ExtensionConfig extensionConfig = {
            topicIdentifier: websub:TOPIC_ID_HEADER_AND_PAYLOAD,
            topicHeader: CUSTOM_SUB_MOCK_HEADER,
            headerResourceMap: {
                "headeronly" : ["onHeaderOnly", CustomSubMockActionEvent],
                "status" : ["onStatus", CustomSubMockActionEvent]
            },
            payloadKeyResourceMap: {
                "action" : {
                    "keyonly" : ["onKeyOnly", CustomSubMockActionEvent]
                },
                "domain" : {
                    "domainkeyonly" : ["onDomainKeyOnly", CustomSubMockDomainEvent]
                }
            },
            headerAndPayloadKeyResourceMap: {
                "issue" : {
                    "action" : {
                        "created" : ["onIssueCreated", CustomSubMockActionEvent],
                        "deleted" : ["onIssueDeleted", CustomSubMockActionEvent]
                    }
                },
                "pull" : {
                    "domain" : {
                        "bugfix" : ["onBugFixPull", CustomSubMockDomainEvent],
                        "feature" : ["onFeaturePull", CustomSubMockDomainEvent]
                    }
                }
            }
        };
        string host = config is () ? "" : config.host;
        websub:SubscriberListenerConfiguration sseConfig = {
            host: host,
            extensionConfig: extensionConfig
        };
        self.websubListener = new(port, sseConfig);
    }

    public function attach(websub:SubscriberService s, string[]|string? name = ()) returns error? {
        return self.websubListener.attach(s, name);
    }

    public function detach(websub:SubscriberService s) returns error? {
        return self.websubListener.detach(s);
    }

    public function 'start() returns error? {
        return self.websubListener.'start();
    }

    public function gracefulStop() returns error? {
        return ();
    }

    public function immediateStop() returns error? {
        return self.websubListener.immediateStop();
    }
}

@test:Config {}
function testOnIntentVerificationInvocation() {
    http:Client clientEndpoint = new ("http://localhost:23585");
    var response = clientEndpoint->get("/key");
    test:assertEquals(fetchOutput(ID_INTENT_VER_REQ_RECEIVED_LOG), INTENT_VER_REQ_RECEIVED_LOG);
}

@test:Config {
    dependsOn: [testOnIntentVerificationInvocation]
}
function testDispatchingByKey() {
    http:Client clientEndpoint = new ("http://localhost:23585");
    json jsonPayload1 = {action: "created"};
    json jsonPayload2 = {domain: "feature"};
    http:Request req1 = new;
    req1.addHeader(http:CONTENT_TYPE, CONTENT_TYPE_JSON);
    req1.setJsonPayload(jsonPayload1);
    http:Request req2 = new;
    req2.addHeader(http:CONTENT_TYPE, CONTENT_TYPE_JSON);
    req2.setJsonPayload(jsonPayload2);

    var response = clientEndpoint->post("/key", req1);
    HttpResponseDetails responseDetails = fetchHttpResponse(response);
    test:assertEquals(responseDetails.statusCode, http:STATUS_ACCEPTED, msg = "Response code mismatched");
    test:assertEquals(fetchOutput(ID_BY_KEY_CREATED_LOG), BY_KEY_CREATED_LOG);

    response = clientEndpoint->post("/key", req2);
    responseDetails = fetchHttpResponse(response);
    test:assertEquals(responseDetails.statusCode, http:STATUS_ACCEPTED, msg = "Response code mismatched");
    test:assertEquals(fetchOutput(ID_BY_KEY_FEATURE_LOG), BY_KEY_FEATURE_LOG);
}

@test:Config {
    dependsOn: [testDispatchingByKey],
    enable:false
}
function testDispatchingByHeader() {
    http:Client clientEndpoint = new ("http://localhost:23686");
    json jsonPayload1 = {action: "deleted"};
    json jsonPayload2 = {action: "created"};
    http:Request req1 = new;
    req1.addHeader(http:CONTENT_TYPE, CONTENT_TYPE_JSON);
    req1.addHeader(CUSTOM_SUB_MOCK_HEADER, "issue");
    req1.setJsonPayload(jsonPayload1);
    http:Request req2 = new;
    req2.addHeader(http:CONTENT_TYPE, CONTENT_TYPE_JSON);
    req2.addHeader(CUSTOM_SUB_MOCK_HEADER, "commit");
    req2.setJsonPayload(jsonPayload2);

    var response1 = clientEndpoint->post("/header", req1);
    HttpResponseDetails responseDetails1 = fetchHttpResponse(response1);
    test:assertEquals(responseDetails1.statusCode, http:STATUS_ACCEPTED, msg = "Response code mismatched");
    test:assertEquals(fetchOutput(ID_BY_HEADER_ISSUE_LOG), BY_HEADER_ISSUE_LOG);

    var response2 = clientEndpoint->post("/header", req2);
    HttpResponseDetails responseDetails2 = fetchHttpResponse(response2);
    test:assertEquals(responseDetails2.statusCode, http:STATUS_ACCEPTED, msg = "Response code mismatched");
    test:assertEquals(fetchOutput(ID_BY_HEADER_COMMIT_LOG), BY_HEADER_COMMIT_LOG);
}

@test:Config {enable: false}
function testDispatchingByHeaderAndPayloadKey() {
    http:Client clientEndpoint = new ("http://localhost:23787");
    json jsonPayload1 = {action: "created"};
    json jsonPayload2 = {domain: "feature"};
    http:Request req1 = new;
    req1.addHeader(http:CONTENT_TYPE, CONTENT_TYPE_JSON);
    req1.addHeader(CUSTOM_SUB_MOCK_HEADER, "issue");
    req1.setJsonPayload(jsonPayload1);
    http:Request req2 = new;
    req2.addHeader(http:CONTENT_TYPE, CONTENT_TYPE_JSON);
    req2.addHeader(CUSTOM_SUB_MOCK_HEADER, "pull");
    req2.setJsonPayload(jsonPayload2);

    var response1 = clientEndpoint->post("/headerAndPayload", req1);
    HttpResponseDetails responseDetails1 = fetchHttpResponse(response1);
    test:assertEquals(responseDetails1.statusCode, http:STATUS_ACCEPTED, msg = "Response code mismatched");
    test:assertEquals(fetchOutput(ID_BY_HEADER_AND_PAYLOAD_ISSUE_CREATED_LOG), BY_HEADER_AND_PAYLOAD_ISSUE_CREATED_LOG);

    var response2 = clientEndpoint->post("/headerAndPayload", req2);
    HttpResponseDetails responseDetails2 = fetchHttpResponse(response2);
    test:assertEquals(responseDetails2.statusCode, http:STATUS_ACCEPTED, msg = "Response code mismatched");
    test:assertEquals(fetchOutput(ID_BY_HEADER_AND_PAYLOAD_FEATURE_PULL_LOG), BY_HEADER_AND_PAYLOAD_FEATURE_PULL_LOG);
}

@test:Config {enable: false}
function testDispatchingByHeaderAndPayloadKeyForOnlyHeader() {
    http:Client clientEndpoint = new ("http://localhost:23787");
    json jsonPayload = {action: "header_only"};
    http:Request req = new;
    req.addHeader(http:CONTENT_TYPE, CONTENT_TYPE_JSON);
    req.addHeader(CUSTOM_SUB_MOCK_HEADER, "headeronly");
    req.setJsonPayload(jsonPayload);

    var response = clientEndpoint->post("/headerAndPayload", req);
    HttpResponseDetails responseDetails = fetchHttpResponse(response);
    test:assertEquals(responseDetails.statusCode, http:STATUS_ACCEPTED, msg = "Response code mismatched");
    test:assertEquals(fetchOutput(ID_BY_HEADER_AND_PAYLOAD_HEADER_ONLY_LOG), BY_HEADER_AND_PAYLOAD_HEADER_ONLY_LOG);
}

@test:Config {
    dependsOn: [testDispatchingByHeaderAndPayloadKeyForOnlyHeader],
    enable:false
}
function testDispatchingByHeaderAndPayloadKeyForOnlyKey() {
    http:Client clientEndpoint = new ("http://localhost:23787");
    json jsonPayload = {action: "keyonly"};
    http:Request req = new;
    req.addHeader(http:CONTENT_TYPE, CONTENT_TYPE_JSON);
    req.addHeader(CUSTOM_SUB_MOCK_HEADER, "key_only");
    req.setJsonPayload(jsonPayload);

    var response = clientEndpoint->post("/headerAndPayload", req);
    HttpResponseDetails responseDetails = fetchHttpResponse(response);
    test:assertEquals(responseDetails.statusCode, http:STATUS_ACCEPTED, msg = "Response code mismatched");
    test:assertEquals(fetchOutput(ID_BY_HEADER_AND_PAYLOAD_KEY_ONLY_LOG), BY_HEADER_AND_PAYLOAD_KEY_ONLY_LOG);
}
