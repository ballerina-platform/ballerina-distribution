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
import ballerina/test;
import ballerina/websub;

listener websub:Listener redirectWebsubEP = new websub:Listener(23484);

@websub:SubscriberServiceConfig {
    path:"/websub",
    subscribeOnStartUp:true,
    target: "http://localhost:23081/original/one",
    leaseSeconds: 3600,
    secret: "Kslk30SNF2AChs2",
    publisherClientConfig: { followRedirects: {
            enabled: true
        }
    },
    hubClientConfig: { followRedirects: {
            enabled: true
        }
    }
}
service redirectWebsubSubscriber on redirectWebsubEP {
    resource function onNotification (websub:Notification notification) {
        var payload = notification.getJsonPayload();
        if (payload is json) {
            io:println("WebSub Notification Received: " + payload.toJsonString());
        } else {
            panic payload;
        }
    }
}

@websub:SubscriberServiceConfig {
    path:"/websubTwo",
    target: "http://localhost:23081/original/two",
    leaseSeconds: 1200,
    secret: "SwklSSf42DLA",
    publisherClientConfig: { followRedirects: {
            enabled: true
        }
    },
    hubClientConfig: { followRedirects: {
            enabled: true
        }
    }
}
service redirectWebsubSubscriberTwo on redirectWebsubEP {
    resource function onNotification (websub:Notification notification) {
        var payload = notification.getJsonPayload();
        if (payload is json) {
            io:println("WebSub Notification Received: " + payload.toJsonString());
        } else {
            panic payload;
        }
    }
}

@test:Config {
    dependsOn: ["testContentReceipt"]
}
function testTopicMovedPermanentlyAndHubTemporaryRedirect() {
    test:assertEquals(fetchOutput(ID_REDIRECT_SUBSCRIBER_ONE_LOG), REDIRECT_SUBSCRIBER_ONE_LOG);
}

@test:Config {
    dependsOn: ["testTopicMovedPermanentlyAndHubTemporaryRedirect"]
}
function testTopicRedirectFoundAndHubPermanentRedirect() {
    test:assertEquals(fetchOutput(ID_REDIRECT_SUBSCRIBER_TWO_LOG), REDIRECT_SUBSCRIBER_TWO_LOG);
}
