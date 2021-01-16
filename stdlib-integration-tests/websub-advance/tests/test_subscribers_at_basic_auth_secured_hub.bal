// // Copyright (c) 2019 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
// //
// // WSO2 Inc. licenses this file to you under the Apache License,
// // Version 2.0 (the "License"); you may not use this file except
// // in compliance with the License.
// // You may obtain a copy of the License at
// //
// // http://www.apache.org/licenses/LICENSE-2.0
// //
// // Unless required by applicable law or agreed to in writing,
// // software distributed under the License is distributed on an
// // "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// // KIND, either express or implied.  See the License for the
// // specific language governing permissions and limitations
// // under the License.

// import ballerina/auth;
// import ballerina/http;
// import ballerina/io;
// import ballerina/lang.runtime as runtime;
// import ballerina/test;
// import ballerina/log;
// import ballerina/websub;

// auth:InboundBasicAuthProvider basicAuthProvider = new;
// http:BasicAuthHandler basicAuthHandler = new(basicAuthProvider);

// websub:Hub webSubHub = startHubAndRegisterTopic();

// listener http:Listener publisherServiceEP = new http:Listener(23080);

// http:BasicAuthHandler outboundBasicAuthHandler = new(new auth:OutboundBasicAuthProvider({
//                                                          username: "anne",
//                                                          password: "abc"
//                                                      }));

// websub:PublisherClient websubHubClientEP = new (webSubHub.publishUrl, {
//     auth: {
//         authHandler: outboundBasicAuthHandler
//     },
//     secureSocket: {
//         trustStore: {
//             path: "tests/resources/security/ballerinaTruststore.p12",
//             password: "ballerina"
//         }
//     }
// });

// http:BasicAuthHandler authnFailingHandler = new(new auth:OutboundBasicAuthProvider({
//                                                          username: "anne",
//                                                          password: "cba"
//                                                }));

// websub:PublisherClient authnFailingClient = new (webSubHub.publishUrl, {
//     auth: {
//         authHandler: authnFailingHandler
//     },
//     secureSocket: {
//         trustStore: {
//             path: "tests/resources/security/ballerinaTruststore.p12",
//             password: "ballerina"
//         }
//     }
// });

// http:BasicAuthHandler authzFailingHandler = new(new auth:OutboundBasicAuthProvider({
//                                                          username: "peter",
//                                                          password: "pqr"
//                                                }));

// websub:PublisherClient authzFailingClient = new (webSubHub.publishUrl, {
//     auth: {
//         authHandler: authzFailingHandler
//     },
//     secureSocket: {
//         trustStore: {
//             path: "tests/resources/security/ballerinaTruststore.p12",
//             password: "ballerina"
//         }
//     }
// });

// service publisher on publisherServiceEP {
//     @http:ResourceConfig {
//         methods: ["GET", "HEAD"]
//     }
//     resource function discover(http:Caller caller, http:Request req) {
//         http:Response response = new;
//         // Add a link header indicating the hub and topic
//         websub:addWebSubLinkHeader(response, [webSubHub.subscriptionUrl], WEBSUB_PERSISTENCE_TOPIC_ONE);
//         var err = caller->accepted(response);
//         if (err is error) {
//             log:printError("Error responding on discovery", err = err);
//         }
//     }

//     @http:ResourceConfig {
//         methods: ["POST"],
//         path: "/notify/{subscriber}"
//     }
//     resource function notify(http:Caller caller, http:Request req, string subscriber) {
//         var payload = req.getJsonPayload();
//         if (payload is error) {
//             panic <error> payload;
//         }

//         checkSubscriberAvailability(WEBSUB_PERSISTENCE_TOPIC_ONE, "http://localhost:" + subscriber + "/websub");
//         var err = webSubHub.publishUpdate(WEBSUB_PERSISTENCE_TOPIC_ONE, <@untainted> <json> payload);
//         if (err is error) {
//             log:printError("Error publishing update directly", err = err);
//         }

//         http:Response response = new;
//         err = caller->accepted(response);
//         if (err is error) {
//             log:printError("Error responding on notify request", err = err);
//         }
//     }
// }

// service publisherTwo on publisherServiceEP {
//     @http:ResourceConfig {
//         methods: ["GET", "HEAD"]
//     }
//     resource function discover(http:Caller caller, http:Request req) {
//         http:Response response = new;
//         // Add a link header indicating the hub and topic
//         websub:addWebSubLinkHeader(response, [webSubHub.subscriptionUrl], WEBSUB_PERSISTENCE_TOPIC_TWO);
//         var err = caller->accepted(response);
//         if (err is error) {
//             log:printError("Error responding on discovery", err = err);
//         }
//     }

//     @http:ResourceConfig {
//         methods: ["POST"]
//     }
//     resource function notify(http:Caller caller, http:Request req) {
//         var payload = req.getJsonPayload();
//         if (payload is error) {
//             panic <error> payload;
//         }

//         checkSubscriberAvailability(WEBSUB_PERSISTENCE_TOPIC_TWO, "http://localhost:23383/websubTwo");
//         var err = webSubHub.publishUpdate(WEBSUB_PERSISTENCE_TOPIC_TWO, <@untainted> <json> payload);
//         if (err is error) {
//             log:printError("Error publishing update directly", err = err);
//         }

//         http:Response response = new;
//         err = caller->accepted(response);
//         if (err is error) {
//             log:printError("Error responding on notify request", err = err);
//         }
//     }
// }

// service publisherThree on publisherServiceEP {
//     @http:ResourceConfig {
//         methods: ["GET", "HEAD"]
//     }
//     resource function discover(http:Caller caller, http:Request req) {
//         http:Response response = new;
//         // Add a link header indicating the hub and topic
//         websub:addWebSubLinkHeader(response, [webSubHub.subscriptionUrl], WEBSUB_TOPIC_ONE);
//         var err = caller->accepted(response);
//         if (err is error) {
//             log:printError("Error responding on discovery", err = err);
//         }
//     }

//     @http:ResourceConfig {
//         methods: ["POST"]
//     }
//     resource function notify(http:Caller caller, http:Request req) {
//         var payload = req.getJsonPayload();
//         if (payload is error) {
//             panic <error> payload;
//         }
//         checkSubscriberAvailability(WEBSUB_TOPIC_ONE, "http://localhost:23484/websubFour");

//         string publishErrorMessagesConcatenated = "";

//         var err = websubHubClientEP->publishUpdate(WEBSUB_TOPIC_ONE, <@untainted> <json> payload);
//         if (err is error) {
//             publishErrorMessagesConcatenated += err.message();
//             log:printError("Error publishing update remotely", err = err);
//         }

//         err = authnFailingClient->publishUpdate(WEBSUB_TOPIC_ONE, <@untainted> <json> payload);
//         if (err is error) {
//             publishErrorMessagesConcatenated += err.message();
//             log:printError("Error publishing update remotely", err = err);
//         }

//         err = authzFailingClient->publishUpdate(WEBSUB_TOPIC_ONE, <@untainted> <json> payload);
//         if (err is error) {
//             publishErrorMessagesConcatenated += err.message();
//             log:printError("Error publishing update remotely", err = err);
//         }

//         err = caller->accepted(<@untainted> publishErrorMessagesConcatenated);
//         if (err is error) {
//             log:printError("Error responding on notify request", err = err);
//         }
//     }
// }

// service helperService on publisherServiceEP {
//     @http:ResourceConfig {
//         methods: ["POST"]
//     }
//     resource function restartHub(http:Caller caller, http:Request req) {
//         checkpanic webSubHub.stop();
//         webSubHub = startHubAndRegisterTopic();
//         checkpanic caller->accepted();
//     }
// }

// function startHubAndRegisterTopic() returns websub:Hub {
//     websub:Hub internalHub = startWebSubHub();
//     var err = internalHub.registerTopic(WEBSUB_PERSISTENCE_TOPIC_ONE);
//     if (err is error) {
//         log:printError("Error registering topic", err = err);
//     }
//     err = internalHub.registerTopic(WEBSUB_PERSISTENCE_TOPIC_TWO);
//     if (err is error) {
//         log:printError("Error registering topic", err = err);
//     }
//     err = internalHub.registerTopic(WEBSUB_TOPIC_ONE);
//     if (err is error) {
//         log:printError("Error registering topic", err = err);
//     }
//     return internalHub;
// }

// function startWebSubHub() returns websub:Hub {
//     var result = websub:startHub(new http:Listener(23192, config =  {
//                 auth: {
//                     authHandlers: [basicAuthHandler]
//                 },
//                 secureSocket: {
//                     keyStore: {
//                         path: "tests/resources/security/ballerinaKeystore.p12",
//                         password: "ballerina"
//                     },
//                     trustStore: {
//                         path: "tests/resources/security/ballerinaTruststore.p12",
//                         password: "ballerina"
//                     }
//                 }
//             }), "/websub", "/hub",
//                 serviceAuth = {enabled:true},
//                 subscriptionResourceAuth = {enabled:true, scopes:["subscribe"]},
//                 publisherResourceAuth = {enabled:true, scopes:["publish"]},
//                 hubConfiguration = { remotePublish : { enabled : true }}
//     );
//     if (result is websub:Hub) {
//         return result;
//     } else if (result is websub:HubStartedUpError) {
//         return result.startedUpHub;
//     } else {
//         panic result;
//     }
// }

// function checkSubscriberAvailability(string topic, string callback) {
//     int count = 0;
//     boolean subscriberAvailable = false;
//     while (!subscriberAvailable && count < 60) {
//         websub:SubscriberDetails[] topicDetails = webSubHub.getSubscribers(topic);
//         if (isSubscriberAvailable(topicDetails, callback)) {
//             return;
//         }
//         runtime:sleep(1);
//         count += 1;
//     }
// }

// function isSubscriberAvailable(websub:SubscriberDetails[] topicDetails, string callback) returns boolean {
//     foreach var detail in topicDetails {
//         if (detail.callback == callback) {
//             return true;
//         }
//     }
//     return false;
// }

// listener websub:Listener websubEP = new websub:Listener(23484);
// auth:OutboundBasicAuthProvider basicAuthProvider1 = new({
//     username: "peter",
//     password: "pqr"
// });

// http:BasicAuthHandler basicAuthHandler1 = new(basicAuthProvider1);

// @websub:SubscriberServiceConfig {
//     path: "/websub",
//     subscribeOnStartUp: true,
//     target: "http://localhost:23080/publisher/discover",
//     leaseSeconds: 3600,
//     secret: "Kslk30SNF2AChs2",
//     hubClientConfig: {
//         auth: { authHandler: basicAuthHandler1 },
//         secureSocket: {
//             trustStore: {
//                 path: "tests/resources/security/ballerinaTruststore.p12",
//                 password: "ballerina"
//             }
//         }
//     }
// }
// service websubSubscriber on websubEP {
//     resource function onNotification (websub:Notification notification) returns @tainted error? {
//         json payload = check notification.getJsonPayload();
//         io:println("WebSub Notification Received by One: " + <@untainted>payload.toJsonString());
//         storeOutput(ID_NOTIFICATION_ONE, "WebSub Notification Received by One: " + <@untainted>payload.toJsonString());
//     }
// }

// auth:OutboundBasicAuthProvider basicAuthProvider2 = new({
//     username: "tom",
//     password: "4321"
// });

// http:BasicAuthHandler basicAuthHandler2 = new(basicAuthProvider2);

// @websub:SubscriberServiceConfig {
//     path: "/websubTwo",
//     subscribeOnStartUp: true,
//     target: "http://localhost:23080/publisherTwo/discover",
//     leaseSeconds: 1200,
//     hubClientConfig: {
//         auth: { authHandler: basicAuthHandler2 },
//         secureSocket: {
//             trustStore: {
//                 path: "tests/resources/security/ballerinaTruststore.p12",
//                 password: "ballerina"
//             }
//         }
//     }
// }
// service websubSubscriberTwo on websubEP {
//     resource function onNotification (websub:Notification notification) returns @tainted error? {
//         json payload = check notification.getJsonPayload();
//         io:println("WebSub Notification Received by Two: " + payload.toJsonString());
//     }
// }

// auth:OutboundBasicAuthProvider basicAuthProvider3 = new({
//     username: "mary",
//     password: "xyz"
// });

// http:BasicAuthHandler basicAuthHandler3 = new(basicAuthProvider3);

// @websub:SubscriberServiceConfig {
//     path: "/websubThree",
//     subscribeOnStartUp: true,
//     target: "http://localhost:23080/publisher/discover",
//     leaseSeconds: 1200,
//     hubClientConfig: {
//         auth: { authHandler: basicAuthHandler3 },
//         secureSocket: {
//             trustStore: {
//                 path: "tests/resources/security/ballerinaTruststore.p12",
//                 password: "ballerina"
//             }
//         }
//     }
// }
// service websubSubscriberThree on websubEP {
//     resource function onNotification (websub:Notification notification) returns @tainted error? {
//         json payload = check notification.getJsonPayload();
//         io:println("WebSub Notification Received by Three: " + payload.toJsonString());
//     }
// }

// auth:OutboundBasicAuthProvider basicAuthProvider4 = new({
//     username: "tom",
//     password: "1234"
// });

// http:BasicAuthHandler basicAuthHandler4 = new(basicAuthProvider4);

// @websub:SubscriberServiceConfig {
//     path: "/websubFour",
//     target: "http://localhost:23080/publisherThree/discover",
//     leaseSeconds: 1200,
//     hubClientConfig: {
//         auth: { authHandler: basicAuthHandler4 },
//         secureSocket: {
//             trustStore: {
//                 path: "tests/resources/security/ballerinaTruststore.p12",
//                 password: "ballerina"
//             }
//         }
//     }
// }
// service websubSubscriberFour on websubEP {
//     resource function onNotification (websub:Notification notification) returns @tainted error? {
//         json payload = check notification.getJsonPayload();
//         io:println("WebSub Notification Received by Four: " + <@untainted>payload.toJsonString());
//         storeOutput(ID_NOTIFICATION_FOUR, "WebSub Notification Received by Four: " + <@untainted>payload.toJsonString());
//     }
// }

// @test:Config{}
// function testDiscoveryAndIntentVerification() {
//     http:Client clientEndpoint = new ("http://localhost:23080");
//     json jsonPayload = {mode: "internal", content_type: "json"};
//     http:Request req = new;
//     req.addHeader(http:CONTENT_TYPE, "application/json");
//     req.setJsonPayload(jsonPayload);
//     var response = clientEndpoint->post("/publisher/notify/23484", req);
//     runtime:sleep(10);
//     test:assertEquals(fetchOutput(ID_NOTIFICATION_ONE), NOTIFICATION_ONE, msg = "Response code mismatched");
// }

// @test:Config{
//     dependsOn: [testDiscoveryAndIntentVerification]
// }
// function testContentReceipt() {
//     http:Client clientEndpoint = new ("http://localhost:23080");
//     json jsonPayload = {mode: "remote", content_type: "xml"};
//     http:Request req = new;
//     req.addHeader(http:CONTENT_TYPE, "application/json");
//     req.setJsonPayload(jsonPayload);
//     var response = clientEndpoint->post("/publisherThree/notify", req);
//     runtime:sleep(10);
//     test:assertEquals(fetchOutput(ID_NOTIFICATION_FOUR), NOTIFICATION_FOUR, msg = "Response code mismatched");
// }

