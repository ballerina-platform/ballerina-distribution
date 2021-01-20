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
import ballerina/io;
import ballerina/log;
import ballerina/lang.runtime as runtime;
import ballerina/websubhub;

boolean remoteTopicRegistered = false;

websubhub:Hub webSubHub = startHubAndRegisterTopic();

websubhub:PublisherClient websubHubClientEP = new (webSubHub.publishUrl);

listener http:Listener publisherServiceEP = new http:Listener(23080);

service /publisher on publisherServiceEP {
    resource function get discover(http:Caller caller, http:Request req) {
        http:Response response = new;
        // Add a link header indicating the hub and topic
        websubhub:addWebSubLinkHeader(response, [webSubHub.subscriptionUrl], WEBSUB_TOPIC_ONE);
        var err = caller->accepted(response);
        if (err is error) {
            log:printError("Error responding on ordering", err = err);
        }
    }

    resource function post notify/[string subscriber](http:Caller caller, http:Request req) {
        remoteRegisterTopic();
        json jsonPayload = <json> checkpanic req.getJsonPayload();
        json jsonMode = <json> checkpanic jsonPayload.mode;
        string mode = jsonMode.toJsonString();
        json jsonContentType = <json> checkpanic jsonPayload.content_type;
        string contentType = jsonContentType.toJsonString();

        var err = caller->accepted();
        if (err is error) {
            log:printError("Error responding on notify request", err = err);
        }

        if (subscriber != "skip_subscriber_check") {
            checkSubscriberAvailability(WEBSUB_TOPIC_ONE, "http://localhost:" + subscriber + "/websub");
            checkSubscriberAvailability(WEBSUB_TOPIC_ONE, "http://localhost:" + subscriber +
                    "/subscriberWithNoPathInAnnot");
            checkSubscriberAvailability(WEBSUB_TOPIC_ONE, "http://localhost:" + subscriber + "/websubThree?topic=" +
                    WEBSUB_TOPIC_ONE + "&fooVal=barVal");
        }

        if (mode == "internal") {
            var result = webSubHub.publishUpdate(WEBSUB_TOPIC_ONE, getPayloadContent(contentType, mode));
            if (result is error) {
                log:printError("Error publishing update directly", err = result);
            }
        } else {
            var result = websubHubClientEP->publishUpdate(WEBSUB_TOPIC_ONE, getPayloadContent(contentType, mode));
            if (result is error) {
                log:printError("Error publishing update remotely", err = result);
            }
        }
    }

    resource function get topicInfo(http:Caller caller, http:Request req) {
        if (req.hasHeader("x-topic")) {
            string topicName = req.getHeader("x-topic");
            websubhub:SubscriberDetails[] details = webSubHub.getSubscribers(topicName);
            var err = caller->respond(details.toString());
            if (err is error) {
                log:printError("Error responding on topicInfo request", err = err);
            }
        } else {
            map<string> allTopics = {};
            int index=1;
            string [] availableTopics = webSubHub.getAvailableTopics();
            foreach var topic in availableTopics {
                allTopics["Topic_" + index.toString()] = topic;
                index += 1;
            }
            json j = <json> checkpanic allTopics.cloneWithType(JsonTypedesc);
            var err = caller->respond(j);
            if (err is error) {
                log:printError("Error responding on topicInfo request", err = err);
            }
        }
    }

    resource function get unsubscribe(http:Caller caller, http:Request req) returns error? {
        check webSubHub.removeSubscription("http://one.websub.topic.com",
                                           "http://localhost:23181/websubThree?topic=http://one.websub.topic.com&fooVal=barVal");
        var err = caller->respond("unsubscription successful");
        if (err is error) {
            log:printError("Error responding on unsubscription request", err = err);
        }
    }
}

service /publisherTwo on publisherServiceEP {
    resource function get discover(http:Caller caller, http:Request req) {
        http:Response response = new;
        // Add a link header indicating the hub and topic
        websubhub:addWebSubLinkHeader(response, [webSubHub.subscriptionUrl], WEBSUB_TOPIC_FOUR);
        var err = caller->accepted(response);
        if (err is error) {
            log:printError("Error responding on ordering", err = err);
        }
    }

    resource function post notify(http:Caller caller, http:Request req) {
        checkSubscrberAvailabilityAndPublishDirectly(WEBSUB_TOPIC_THREE, "http://localhost:23383/websub",
                                                     {"action":"publish","mode":"internal-hub"});
        checkSubscrberAvailabilityAndPublishDirectly(WEBSUB_TOPIC_FOUR, "http://localhost:23383/websubTwo",
                                                     {"action":"publish","mode":"internal-hub-two"});

        var err = caller->accepted();
        if (err is error) {
            log:printError("Error responding on notify request", err = err);
        }
    }
}

service /contentTypePublisher on publisherServiceEP {
    resource function post notify/[string port](http:Caller caller, http:Request req) {
        json jsonPayload = <json> checkpanic req.getJsonPayload();
        json jsonMode = <json> checkpanic jsonPayload.mode;
        string mode = jsonMode.toJsonString();
        json jsonContentType = <json> checkpanic jsonPayload.content_type;
        string contentType = jsonContentType.toJsonString();

        var err = caller->accepted();
        if (err is error) {
            log:printError("Error responding on notify request", err = err);
        }

        if (port != "skip_subscriber_check") {
            checkSubscriberAvailability(WEBSUB_TOPIC_ONE, "http://localhost:" + port + "/websub");
            checkSubscriberAvailability(WEBSUB_TOPIC_ONE, "http://localhost:" + port + "/websubTwo");
        }

        if (mode == "internal") {
            var result = webSubHub.publishUpdate(WEBSUB_TOPIC_ONE, getPayloadContent(contentType, mode));
            if (result is error) {
                log:printError("Error publishing update directly", err = result);
            }
        } else {
            var result = websubHubClientEP->publishUpdate(WEBSUB_TOPIC_ONE, getPayloadContent(contentType, mode));
            if (result is error) {
                log:printError("Error publishing update remotely", err = result);
            }
        }
    }
}

function checkSubscrberAvailabilityAndPublishDirectly(string topic, string subscriber, json payload) {
    checkSubscriberAvailability(topic, subscriber);
    var err = webSubHub.publishUpdate(topic, payload);
    if (err is error) {
        log:printError("Error publishing update directly", err = err);
    }
}

function startHubAndRegisterTopic() returns websubhub:Hub {
    websubhub:Hub internalHub = startWebSubHub();
    var err = internalHub.registerTopic(WEBSUB_TOPIC_ONE);
    if (err is error) {
        log:printError("Error registering topic directly", err = err);
    }
    err = internalHub.registerTopic(WEBSUB_TOPIC_THREE);
    if (err is error) {
        log:printError("Error registering topic directly", err = err);
    }
    err = internalHub.registerTopic(WEBSUB_TOPIC_FOUR);
    if (err is error) {
        log:printError("Error registering topic directly", err = err);
    }
    err = internalHub.registerTopic(WEBSUB_TOPIC_FIVE);
    if (err is error) {
        log:printError("Error registering topic directly", err = err);
    }
    err = internalHub.registerTopic(WEBSUB_TOPIC_SIX);
    if (err is error) {
        log:printError("Error registering topic directly", err = err);
    }
    return internalHub;
}

function startWebSubHub() returns websubhub:Hub {
    var result = websubhub:startHub(new http:Listener(23191), "/websub", "/hub",
                                 hubConfiguration = { remotePublish : { enabled : true }});
    if (result is websubhub:Hub) {
        return result;
    } else if (result is websubhub:HubStartedUpError) {
        return result.startedUpHub;
    } else {
        panic result;
    }
}

function remoteRegisterTopic()  {
    if (remoteTopicRegistered) {
        return;
    }
    var err = websubHubClientEP->registerTopic(WEBSUB_TOPIC_TWO);
    if (err is error) {
        log:printError("Error registering topic remotely", err = err);
    }
    remoteTopicRegistered = true;
}

function getPayloadContent(string contentType, string mode) returns string|xml|json|byte[]|io:ReadableByteChannel {
    string errorMessage = "unknown content type";
    if (contentType == "" || contentType == "json") {
        if (mode == "internal") {
            json j = {"action":"publish","mode":"internal-hub"};
            return j;
        }
        json k = {"action":"publish","mode":"remote-hub"};
        return k;
    } else if (contentType == "string") {
        if (mode == "internal") {
            return "Text update for internal Hub";
        }
        return "Text update for remote Hub";
    } else if (contentType == "xml") {
        if (mode == "internal") {
            return xml `<websub><request>Notification</request><type>Internal</type></websub>`;
        }
        return xml `<websub><request>Notification</request><type>Remote</type></websub>`;
    } else if (contentType == "byte[]" || contentType == "io:ReadableByteChannel") {
        errorMessage = "content type " + contentType + " not yet supported with WebSub tests";
    }
    error e = error(errorMessage);
    panic e;
}

function checkSubscriberAvailability(string topic, string callback) {
    int count = 0;
    boolean subscriberAvailable = false;
    while (!subscriberAvailable && count < 60) {
        websubhub:SubscriberDetails[] topicDetails = webSubHub.getSubscribers(topic);
        if (isSubscriberAvailable(topicDetails, callback)) {
            return;
        }
        runtime:sleep(1);
        count += 1;
    }
}

function isSubscriberAvailable(websubhub:SubscriberDetails[] topicDetails, string callback) returns boolean {
    foreach var detail in topicDetails {
        if (detail.callback == callback) {
            return true;
        }
    }
    return false;
}

type JsonTypedesc typedesc<json>;
