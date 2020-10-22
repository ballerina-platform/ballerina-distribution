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
import ballerina/runtime;
import ballerina/task;
import ballerina/test;

const HTTP_MESSAGE = "Hello from http service";
const TASK_MESSAGE = "Hello from task service";

http:Client httpClient = new ("http://localhost:15001/HttpService");
listener http:Listener backEndListener = new (15001);
listener http:Listener clientListener = new (15002);

string http_payload = "";

service PostToHttpService = service {
    resource function onTrigger(string message) {
        http:Request request = new;
        request.setTextPayload(<@untainted string>message);
        var result = httpClient->post("/", request);
        if (result is http:ClientError) {
            panic result;
        } else if (result is http:Response) {
            if (result.statusCode == 200) {
                var payload = result.getTextPayload();
                if (payload is http:ClientError) {
                    panic payload;
                } else {
                    http_payload = <@untainted string>payload;
                }
            }
        }
    }
};

@http:ServiceConfig {
    basePath: "/"
}
service GetResultService on clientListener {
    @http:ResourceConfig {
        methods: ["GET"],
        path: "/"
    }
    resource function getResult(http:Caller caller, http:Request request) {
        var result = caller->respond(http_payload);
    }
}

service HttpService on backEndListener {
    @http:ResourceConfig {
        methods: ["POST"],
        path: "/"
    }
    resource function handlePost(http:Caller caller, http:Request request) {
        http:Response response = new;
        var requestMessage = request.getTextPayload();
        if (requestMessage is error) {
            response.statusCode = 501;
            response.setTextPayload("[HTTP Service] Failed to retrieve the request");
        } else {
            if (requestMessage == TASK_MESSAGE) {
                response.statusCode = 200;
                response.setTextPayload(HTTP_MESSAGE);
            } else {
                response.statusCode = 400;
                response.setTextPayload("[HTTP Service] Invalid Request Message Received");
            }
        }
        var result = caller->respond(response);
        if (result is http:ListenerError) {
            panic result;
        }
    }
}

@test:Config {}
function testTaskWithHttpClient() {
    http:Client multipleAttachmentClientEndpoint = new ("http://localhost:15002");
    task:Scheduler timerForHttpClient = new ({intervalInMillis: 1000, initialDelayInMillis: 1000});
    var attachResult = timerForHttpClient.attach(PostToHttpService, TASK_MESSAGE);
    if (attachResult is task:SchedulerError) {
        panic attachResult;
    } else {
        var startResult = timerForHttpClient.start();
        if (startResult is error) {
            panic startResult;
        }
    }
    runtime:sleep(4000);
    var response = multipleAttachmentClientEndpoint->get("/");
    checkpanic timerForHttpClient.stop();
    if (response is http:Response) {
        test:assertEquals(response.getTextPayload(), HTTP_MESSAGE, msg = "Response payload mismatched");
    } else {
        test:assertFail(msg = (<error>response).message());
    }
}
