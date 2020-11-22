//// Copyright (c) 2019 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
////
//// WSO2 Inc. licenses this file to you under the Apache License,
//// Version 2.0 (the "License"); you may not use this file except
//// in compliance with the License.
//// You may obtain a copy of the License at
////
//// http://www.apache.org/licenses/LICENSE-2.0
////
//// Unless required by applicable law or agreed to in writing,
//// software distributed under the License is distributed on an
//// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//// KIND, either express or implied.  See the License for the
//// specific language governing permissions and limitations
//// under the License.
//
//import ballerina/auth;
//import ballerina/http;
//import ballerina/log;
//import ballerina/runtime;
//import ballerina/websub;
//
//auth:InboundBasicAuthProvider basicAuthProvider = new;
//http:BasicAuthHandler basicAuthHandler = new(basicAuthProvider);
//
//websub:Hub authWebSubHub = authStartHubAndRegisterTopic();
//
//listener http:Listener authPublisherServiceEP = new http:Listener(23084);
//
//http:BasicAuthHandler outboundBasicAuthHandler = new(new auth:OutboundBasicAuthProvider({
//                                                         username: "anne",
//                                                         password: "abc"
//                                                     }));
//
//websub:PublisherClient authWebsubHubClientEP = new (authWebSubHub.publishUrl, {
//    auth: {
//        authHandler: outboundBasicAuthHandler
//    },
//    secureSocket: {
//        trustStore: {
//            path: "tests/resources/security/ballerinaTruststore.p12",
//            password: "ballerina"
//        }
//    }
//});
//
//http:BasicAuthHandler authnFailingHandler = new(new auth:OutboundBasicAuthProvider({
//                                                         username: "anne",
//                                                         password: "cba"
//                                               }));
//
//websub:PublisherClient authnFailingClient = new (authWebSubHub.publishUrl, {
//    auth: {
//        authHandler: authnFailingHandler
//    },
//    secureSocket: {
//        trustStore: {
//            path: "src/websub_advanced_integration_tests/resources/security/ballerinaTruststore.p12",
//            password: "ballerina"
//        }
//    }
//});
//
//http:BasicAuthHandler authzFailingHandler = new(new auth:OutboundBasicAuthProvider({
//                                                         username: "peter",
//                                                         password: "pqr"
//                                               }));
//
//websub:PublisherClient authzFailingClient = new (authWebSubHub.publishUrl, {
//    auth: {
//        authHandler: authzFailingHandler
//    },
//    secureSocket: {
//        trustStore: {
//            path: "src/websub_advanced_integration_tests/resources/security/ballerinaTruststore.p12",
//            password: "ballerina"
//        }
//    }
//});
//
//service publisher3 on authPublisherServiceEP {
//    @http:ResourceConfig {
//        methods: ["GET", "HEAD"]
//    }
//    resource function discover(http:Caller caller, http:Request req) {
//        http:Response response = new;
//        // Add a link header indicating the hub and topic
//        websub:addWebSubLinkHeader(response, [authWebSubHub.subscriptionUrl], WEBSUB_PERSISTENCE_TOPIC_ONE);
//        var err = caller->accepted(response);
//        if (err is error) {
//            log:printError("Error responding on discovery", err);
//        }
//    }
//
//    @http:ResourceConfig {
//        methods: ["POST"],
//        path: "/notify/{subscriber}"
//    }
//    resource function notify(http:Caller caller, http:Request req, string subscriber) {
//        var payload = req.getJsonPayload();
//        if (payload is error) {
//            panic <error> payload;
//        }
//
//        authCheckSubscriberAvailability(WEBSUB_PERSISTENCE_TOPIC_ONE, "http://localhost:" + subscriber + "/websub");
//        var err = authWebSubHub.publishUpdate(WEBSUB_PERSISTENCE_TOPIC_ONE, <@untainted> <json> payload);
//        if (err is error) {
//            log:printError("Error publishing update directly", err);
//        }
//
//        http:Response response = new;
//        err = caller->accepted(response);
//        if (err is error) {
//            log:printError("Error responding on notify request", err);
//        }
//    }
//}
//
//service authpublisherTwo on authPublisherServiceEP {
//    @http:ResourceConfig {
//        methods: ["GET", "HEAD"]
//    }
//    resource function discover(http:Caller caller, http:Request req) {
//        http:Response response = new;
//        // Add a link header indicating the hub and topic
//        websub:addWebSubLinkHeader(response, [authWebSubHub.subscriptionUrl], WEBSUB_PERSISTENCE_TOPIC_TWO);
//        var err = caller->accepted(response);
//        if (err is error) {
//            log:printError("Error responding on discovery", err);
//        }
//    }
//
//    @http:ResourceConfig {
//        methods: ["POST"]
//    }
//    resource function notify(http:Caller caller, http:Request req) {
//        var payload = req.getJsonPayload();
//        if (payload is error) {
//            panic <error> payload;
//        }
//
//        authCheckSubscriberAvailability(WEBSUB_PERSISTENCE_TOPIC_TWO, "http://localhost:23383/websubTwo");
//        var err = authWebSubHub.publishUpdate(WEBSUB_PERSISTENCE_TOPIC_TWO, <@untainted> <json> payload);
//        if (err is error) {
//            log:printError("Error publishing update directly", err);
//        }
//
//        http:Response response = new;
//        err = caller->accepted(response);
//        if (err is error) {
//            log:printError("Error responding on notify request", err);
//        }
//    }
//}
//
//service publisherThree on authPublisherServiceEP {
//    @http:ResourceConfig {
//        methods: ["GET", "HEAD"]
//    }
//    resource function discover(http:Caller caller, http:Request req) {
//        http:Response response = new;
//        // Add a link header indicating the hub and topic
//        websub:addWebSubLinkHeader(response, [authWebSubHub.subscriptionUrl], WEBSUB_TOPIC_ONE);
//        var err = caller->accepted(response);
//        if (err is error) {
//            log:printError("Error responding on discovery", err);
//        }
//    }
//
//    @http:ResourceConfig {
//        methods: ["POST"]
//    }
//    resource function notify(http:Caller caller, http:Request req) {
//        var payload = req.getJsonPayload();
//        if (payload is error) {
//            panic <error> payload;
//        }
//        authCheckSubscriberAvailability(WEBSUB_TOPIC_ONE, "http://localhost:23485/websubFour");
//
//        string publishErrorMessagesConcatenated = "";
//
//        var err = authWebsubHubClientEP->publishUpdate(WEBSUB_TOPIC_ONE, <@untainted> <json> payload);
//        if (err is error) {
//            publishErrorMessagesConcatenated += err.message();
//            log:printError("Error publishing update remotely", err);
//        }
//
//        err = authnFailingClient->publishUpdate(WEBSUB_TOPIC_ONE, <@untainted> <json> payload);
//        if (err is error) {
//            publishErrorMessagesConcatenated += err.message();
//            log:printError("Error publishing update remotely", err);
//        }
//
//        err = authzFailingClient->publishUpdate(WEBSUB_TOPIC_ONE, <@untainted> <json> payload);
//        if (err is error) {
//            publishErrorMessagesConcatenated += err.message();
//            log:printError("Error publishing update remotely", err);
//        }
//
//        err = caller->accepted(<@untainted> publishErrorMessagesConcatenated);
//        if (err is error) {
//            log:printError("Error responding on notify request", err);
//        }
//    }
//}
//
//service helperService on authPublisherServiceEP {
//    @http:ResourceConfig {
//        methods: ["POST"]
//    }
//    resource function restartHub(http:Caller caller, http:Request req) {
//        checkpanic authWebSubHub.stop();
//        authWebSubHub = authStartHubAndRegisterTopic();
//        checkpanic caller->accepted();
//    }
//}
//
//function authStartHubAndRegisterTopic() returns websub:Hub {
//    websub:Hub internalHub = authStartWebSubHub();
//    var err = internalHub.registerTopic(WEBSUB_PERSISTENCE_TOPIC_ONE);
//    if (err is error) {
//        log:printError("Error registering topic", err);
//    }
//    err = internalHub.registerTopic(WEBSUB_PERSISTENCE_TOPIC_TWO);
//    if (err is error) {
//        log:printError("Error registering topic", err);
//    }
//    err = internalHub.registerTopic(WEBSUB_TOPIC_ONE);
//    if (err is error) {
//        log:printError("Error registering topic", err);
//    }
//    return internalHub;
//}
//
//function authStartWebSubHub() returns websub:Hub {
//    var result = websub:startHub(new http:Listener(23192, config =  {
//                auth: {
//                    authHandlers: [basicAuthHandler]
//                },
//                secureSocket: {
//                    keyStore: {
//                        path: "tests/resources/security/ballerinaKeystore.p12",
//                        password: "ballerina"
//                    },
//                    trustStore: {
//                        path: "tests/resources/security/ballerinaTruststore.p12",
//                        password: "ballerina"
//                    }
//                }
//            }), "/websub", "/hub",
//                serviceAuth = {enabled:true},
//                subscriptionResourceAuth = {enabled:true, scopes:["subscribe"]},
//                publisherResourceAuth = {enabled:true, scopes:["publish"]},
//                hubConfiguration = { remotePublish : { enabled : true }}
//    );
//    if (result is websub:Hub) {
//        return result;
//    } else if (result is websub:HubStartedUpError) {
//        return result.startedUpHub;
//    } else {
//        panic result;
//    }
//}
//
//function authCheckSubscriberAvailability(string topic, string callback) {
//    int count = 0;
//    boolean subscriberAvailable = false;
//    while (!subscriberAvailable && count < 60) {
//        websub:SubscriberDetails[] topicDetails = authWebSubHub.getSubscribers(topic);
//        if (authIsSubscriberAvailable(topicDetails, callback)) {
//            return;
//        }
//        runtime:sleep(1000);
//        count += 1;
//    }
//}
//
//function authIsSubscriberAvailable(websub:SubscriberDetails[] topicDetails, string callback) returns boolean {
//    foreach var detail in topicDetails {
//        if (detail.callback == callback) {
//            return true;
//        }
//    }
//    return false;
//}
