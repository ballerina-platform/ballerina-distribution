// Copyright (c) 2019 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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
import ballerina/test;
import ballerina/io;
import ballerina/config;
import ballerina/websub;
import ballerina/websubhub;

listener http:Listener testSubscriber = new(23386);
listener http:Listener testHub = new(23190);

service websub:SubscriberService /subscriber on testSubscriber {
    resource function get 'start(http:Caller caller, http:Request request) returns error? {

        websub:Listener l1 = new(23387);
        websub:Listener l2 = new(23387);

        string responseMsg = "";
        var l1Error = l1.'start();
        if (l1Error is error) {
            log:printError("listener_1 has not started");
            string errMsg = l1Error.message();
            return caller->respond(errMsg);
        }
        log:print("listener_1 has started");

        var l2Error = l2.'start();
        if (l2Error is error) {
            log:printError("listener_2 has not started");
            responseMsg = l2Error.message();
        } else {
            responseMsg = "listener_2 has started";
        }
        l1Error = l1.gracefulStop();
        l2Error = l2.gracefulStop();

        return caller->respond(responseMsg);
    }
}

service /startupHub on testHub {
    resource function get startup(http:Caller caller, http:Request request) returns error? {
        http:Listener lis0 = new (23391);
        http:Listener lis1 = new (23392);
        websubhub:Hub|websubhub:HubStartedUpError|websubhub:HubStartupError res =
            websubhub:startHub(lis0, "/websub", "/hub", "/pub", publicUrl = "https://localhost:23391");

        if (res is websubhub:Hub) {
            if (res.publishUrl != "https://localhost:23391/websub/pub" ||
                    res.subscriptionUrl != "https://localhost:23391/websub/hub") {
                return caller->respond("invalid publishUrl and subscriptionUrl");
            }
        } else {
            io:println(res);
            return caller->respond("hub(lis0) start up error");
        }

        // testHubStartUpWhenStarted
        websubhub:Hub|websubhub:HubStartedUpError|websubhub:HubStartupError res2 = websubhub:startHub(lis1);

        if !(res2 is websubhub:HubStartedUpError) || res2.startedUpHub !== res {
            return caller->respond("seperate hub(lis1) has started");
        }

        // testHubShutdownAndStart
        websubhub:Hub hub = <websubhub:Hub> checkpanic res;
        error? err = hub.stop();
        if (err is error) {
            io:println(err);
            return caller->respond("hub(lis0) stop error");
        }

        http:Listener lis2 = new (23393);
        res2 = websubhub:startHub(lis2);
        if res2 is websubhub:Hub {
            string responseMsg = res2.publishUrl == "http://localhost:23393/publish" && res2.subscriptionUrl ==
                            "http://localhost:23393/" ? "hub(lis2) start successfully" :
                            "incorrect hub(lis2) has started";
            err = res2.stop();
            return caller->respond(responseMsg);
        }
        return caller->respond("hub(lis2) start up error");
    }

    resource function get testPublisherAndSubscriptionInvalidSameResourcePath(http:Caller caller, http:Request request)
                                                                                                    returns error? {
        http:Listener lis = new (23394);
        websubhub:Hub|websubhub:HubStartedUpError|websubhub:HubStartupError res =
            websubhub:startHub(lis, "/websub", "/hub", "/hub");

        var err = lis.gracefulStop();

        if (res is websubhub:HubStartupError) {
            return caller->respond(res.message());
        }
        return caller->respond("Unexpected result");
    }
}

@test:Config {
    //dependsOn: [testJsonContentReceiptForRemoteHub]
}
function testMultipleSubscribersStartUpInSamePort() {
    http:Client clientEndpoint = new ("http://0.0.0.0:23386");
    var response = clientEndpoint->get("/subscriber/start");
    HttpResponseDetails responseDetails = fetchHttpResponse(response);

    test:assertEquals(responseDetails.statusCode, http:STATUS_OK, msg = "Response code mismatched");
    string expectedResponseMsg = "failed to start server connector '0.0.0.0:23387': Address already in use: bind";
    if (config:getAsString("OS_TYPE") == "windows") {
        test:assertEquals(responseDetails.responseMessage, expectedResponseMsg);
    } else {
        expectedResponseMsg = "failed to start server connector '0.0.0.0:23387': Address already in use";
        test:assertEquals(responseDetails.responseMessage, expectedResponseMsg);
    }
}
