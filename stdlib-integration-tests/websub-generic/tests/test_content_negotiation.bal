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

import ballerina/http;
import ballerina/log;
import ballerina/stringutils;
import ballerina/test;
import ballerina/websub;
import ballerina/websubhub;

websubhub:Hub WebSubHub = startHubAndRegisterTopic();
listener http:Listener publisherServiceEPOne = new http:Listener(24080);
listener websub:Listener websubSubscriberEPOne = new websub:Listener(24081);
listener websub:Listener websubSubscriberEPTwo = new websub:Listener(24082);
listener websub:Listener websubSubscriberEPThree = new websub:Listener(24083);
listener websub:Listener websubSubscriberEPFour = new websub:Listener(24084);
listener websub:Listener websubSubscriberEPFive = new websub:Listener(24085);
listener websub:Listener websubSubscriberEPSix = new websub:Listener(24086);
listener websub:Listener websubSubscriberEPSeven = new websub:Listener(24087);
listener websub:Listener websubSubscriberEPEight = new websub:Listener(24088);
listener websub:Listener websubSubscriberEPNine = new websub:Listener(24089);

service /publisherService on publisherServiceEPOne {
    resource function get withAcceptAndAcceptLanguageHeaderArray(http:Caller caller, http:Request req) {
        http:Response response = new;
        if (!(req.hasHeader(HEADER_ACCEPT) && req.hasHeader(HEADER_ACCEPT_LANGUAGE))) {
            response.statusCode = 500;
            var result = caller->respond(response);
            log:printError("Error responding", err = result);
            storeOutput(ID_MISSING_ACCEPT_AND_ACCEPT_LANGUAGE_HEADERS, response.statusCode);
        } else {
            string mediaType = req.getHeader(HEADER_ACCEPT);
            string languageType = req.getHeader(HEADER_ACCEPT_LANGUAGE);
            if (stringutils:contains(mediaType, CONTENT_TYPE_JSON) && stringutils:contains(languageType, LANGUAGE_TYPE_DE)) {
                websubhub:addWebSubLinkHeader(response, [WebSubHub.subscriptionUrl], WEBSUB_TOPIC_ONE);
                response.statusCode = 202;
                var result = caller->respond(response);
                storeOutput(ID_MATCH_ACCEPT_AND_ACCEPT_LANGUAGE_HEADER_ARRAY, response.statusCode);
                if (result is error) {
                    log:printError("Error responding", err = result);
                }
            } else {
                response.statusCode = 406;
                var result = caller->respond(response);
                log:printError("Error responding", err = result);
                storeOutput(ID_MISMATCH_ACCEPT_AND_ACCEPT_LANGUAGE_HEADER_ARRAY, response.statusCode);
            }
        }
    }

    resource function get withAcceptAndAcceptLanguageHeaders(http:Caller caller, http:Request req) {
        http:Response response = new;
        if (!(req.hasHeader(HEADER_ACCEPT) && req.hasHeader(HEADER_ACCEPT_LANGUAGE))) {
            response.statusCode = 500;
            var result = caller->respond(response);
            log:printError("Error responding", err = result);
            storeOutput(ID_MISSING_ACCEPT_AND_ACCEPT_LANGUAGE_HEADERS, response.statusCode);
        } else {
             string mediaType = req.getHeader(HEADER_ACCEPT);
             string languageType = req.getHeader(HEADER_ACCEPT_LANGUAGE);
             if (mediaType == CONTENT_TYPE_JSON && languageType == LANGUAGE_TYPE_DE) {
                 websubhub:addWebSubLinkHeader(response, [WebSubHub.subscriptionUrl], WEBSUB_TOPIC_ONE);
                 response.statusCode = 202;
                 var result = caller->respond(response);
                 storeOutput(ID_MATCH_ACCEPT_AND_ACCEPT_LANGUAGE_HEADERS, response.statusCode);
                 if (result is error) {
                     log:printError("Error responding", err = result);
                 }
             } else {
                response.statusCode = 406;
                var result = caller->respond(response);
                log:printError("Error responding", err = result);
                storeOutput(ID_MISMATCH_ACCEPT_AND_ACCEPT_LANGUAGE_HEADERS, response.statusCode);
            }
        }
    }

    resource function get withAcceptHeader(http:Caller caller, http:Request req) {
        http:Response response = new;
        string mediaType = req.getHeader(HEADER_ACCEPT);
        if (mediaType == CONTENT_TYPE_JSON) {
            websubhub:addWebSubLinkHeader(response, [WebSubHub.subscriptionUrl], WEBSUB_TOPIC_ONE);
            response.statusCode = 202;
            var result = caller->respond(response);
            storeOutput(ID_MATCH_ACCEPT_HEADER, response.statusCode);
            if (result is error) {
                log:printError("Error responding", err = result);
            }
        } else {
            response.statusCode = 406;
            var result = caller->respond(response);
            log:printError("Error responding", err = result);
            storeOutput(ID_MISMATCH_ACCEPT_HEADER, response.statusCode);
        }
    }

    resource function get withAcceptLanguageHeader(http:Caller caller, http:Request req) {
        http:Response response = new;
        string languageType = req.getHeader(HEADER_ACCEPT_LANGUAGE);
        if (languageType == LANGUAGE_TYPE_DE) {
            websubhub:addWebSubLinkHeader(response, [WebSubHub.subscriptionUrl], WEBSUB_TOPIC_ONE);
            response.statusCode = 202;
            var result = caller->respond(response);
            storeOutput(ID_MATCH_ACCEPT_LANGUAGE_HEADER, response.statusCode);
            if (result is error) {
                log:printError("Error responding", err = result);
            }
        } else {
            response.statusCode = 406;
            var result = caller->respond(response);
            log:printError("Error responding", err = result);
            storeOutput(ID_MISMATCH_ACCEPT_LANGUAGE_HEADER, response.statusCode);
        }
    }
}

// do nothing for every onNotification functions.Just for SubscriberServiceConfig annotation.Testing for new fields
// of SubscriberServiceConfig annotation is done by checking status code of response from initial discovery request

@websub:SubscriberServiceConfig {
    subscribeOnStartUp: true,
    target: "http://localhost:24080/publisherService/withAcceptAndAcceptLanguageHeaderArray",
    accept: ["application/json", "application/xml", "text/html"],
    acceptLanguage: ["de-DE", "de-US"],
    leaseSeconds: 3600,
    secret: "Kslk30SNF2AChs2"
}
service websub:SubscriberService /subcriberMatchingAcceptAndAcceptLanguageHeaderArray on websubSubscriberEPEight {
    remote function onNotification(websub:Notification notification) {}
}

@websub:SubscriberServiceConfig {
    subscribeOnStartUp: true,
    target: "http://localhost:24080/publisherService/withAcceptAndAcceptLanguageHeaderArray",
    accept: ["text/csv", "text/plain"],
    acceptLanguage: ["en-US", "en-CA"],
    leaseSeconds: 3600,
    secret: "Kslk30SNF2AChs2"
}
service websub:SubscriberService /subcriberMisMatchingAcceptAndAcceptLanguageHeaderArray on websubSubscriberEPNine {
    remote function onNotification(websub:Notification notification) {}
}

@websub:SubscriberServiceConfig {
    subscribeOnStartUp: true,
    target: "http://localhost:24080/publisherService/withAcceptAndAcceptLanguageHeaders",
    accept: "application/json",
    acceptLanguage: "de-DE",
    leaseSeconds: 3600,
    secret: "Kslk30SNF2AChs2"
}
service websub:SubscriberService /subcriberMatchingAcceptAndAcceptLanguageHeaders on websubSubscriberEPOne {
    remote function onNotification(websub:Notification notification) {}
}

@websub:SubscriberServiceConfig {
    subscribeOnStartUp: true,
    target: "http://localhost:24080/publisherService/withAcceptAndAcceptLanguageHeaders",
    accept: "text/html",
    acceptLanguage: "de-US",
    leaseSeconds: 3600,
    secret: "Kslk30SNF2AChs2"
}
service websub:SubscriberService /subcriberMisMatchingAcceptAndAcceptLanguageHeaders on websubSubscriberEPTwo {
    remote function onNotification(websub:Notification notification) {}
}

@websub:SubscriberServiceConfig {
    subscribeOnStartUp: true,
    target: "http://localhost:24080/publisherService/withAcceptHeader",
    accept: "application/json",
    leaseSeconds: 3600,
    secret: "Kslk30SNF2AChs2"
}
service websub:SubscriberService /subcriberMatchingAcceptHeader on websubSubscriberEPThree {
    remote function onNotification(websub:Notification notification) {}
}

@websub:SubscriberServiceConfig {
    subscribeOnStartUp: true,
    target: "http://localhost:24080/publisherService/withAcceptHeader",
    accept: "text/html",
    leaseSeconds: 3600,
    secret: "Kslk30SNF2AChs2"
}
service websub:SubscriberService /subcriberMisMatchingAcceptHeader on websubSubscriberEPFour {
    remote function onNotification(websub:Notification notification) {}
}

@websub:SubscriberServiceConfig {
    subscribeOnStartUp: true,
    target: "http://localhost:24080/publisherService/withAcceptLanguageHeader",
    acceptLanguage: "de-DE",
    leaseSeconds: 3600,
    secret: "Kslk30SNF2AChs2"
}
service websub:SubscriberService /subcriberMatchingAcceptLanguageHeader on websubSubscriberEPFive {
    remote function onNotification(websub:Notification notification) {}
}

@websub:SubscriberServiceConfig {
    subscribeOnStartUp: true,
    target: "http://localhost:24080/publisherService/withAcceptLanguageHeader",
    acceptLanguage: "de-US",
    leaseSeconds: 3600,
    secret: "Kslk30SNF2AChs2"
}
service websub:SubscriberService /subcriberMisMatchingAcceptLanguageHeader on websubSubscriberEPSix {
    remote function onNotification(websub:Notification notification) {}
}

@websub:SubscriberServiceConfig {
    subscribeOnStartUp: true,
    target: "http://localhost:24080/publisherService/withAcceptAndAcceptLanguageHeaders",
    leaseSeconds: 3600,
    secret: "Kslk30SNF2AChs2"
}
service websub:SubscriberService /subcriberMissingAcceptAndAcceptLanguageHeaders on websubSubscriberEPSeven {
    remote function onNotification(websub:Notification notification) {}
}

@test:Config {}
function testMatchingAcceptAndAcceptLanguageHeaderArray() {
    test:assertEquals(fetchOutput(ID_MATCH_ACCEPT_AND_ACCEPT_LANGUAGE_HEADER_ARRAY), RESPONSE_CODE_ACCEPTED);
}

@test:Config {}
function testMisMatchingAcceptAndAcceptLanguageHeaderArray() {
    test:assertEquals(fetchOutput(ID_MISMATCH_ACCEPT_AND_ACCEPT_LANGUAGE_HEADER_ARRAY), RESPONSE_CODE_NOT_ACCEPTABLE);
}

@test:Config {}
function testMatchingAcceptAndAcceptLanguageHeaders() {
    test:assertEquals(fetchOutput(ID_MATCH_ACCEPT_AND_ACCEPT_LANGUAGE_HEADERS), RESPONSE_CODE_ACCEPTED);
}

@test:Config {}
function testMisMatchingAcceptAndAcceptLanguageHeaders() {
    test:assertEquals(fetchOutput(ID_MISMATCH_ACCEPT_AND_ACCEPT_LANGUAGE_HEADERS), RESPONSE_CODE_NOT_ACCEPTABLE);
}

@test:Config {}
function testMatchingAcceptHeader() {
    test:assertEquals(fetchOutput(ID_MATCH_ACCEPT_HEADER), RESPONSE_CODE_ACCEPTED);
}

@test:Config {}
function testMisMatchingAcceptHeader() {
    test:assertEquals(fetchOutput(ID_MISMATCH_ACCEPT_HEADER), RESPONSE_CODE_NOT_ACCEPTABLE);
}

@test:Config {}
function testMatchingAcceptLanguageHeader() {
    test:assertEquals(fetchOutput(ID_MATCH_ACCEPT_LANGUAGE_HEADER), RESPONSE_CODE_ACCEPTED);
}

@test:Config {}
function testMisMatchingAcceptLanguageHeader() {
    test:assertEquals(fetchOutput(ID_MISMATCH_ACCEPT_LANGUAGE_HEADER), RESPONSE_CODE_NOT_ACCEPTABLE);
}

@test:Config {}
function testMissingAcceptAndAcceptLanguageHeaders() {
    test:assertEquals(fetchOutput(ID_MISSING_ACCEPT_AND_ACCEPT_LANGUAGE_HEADERS), RESPONSE_CODE_INTERNAL_SERVER_ERROR);
}
