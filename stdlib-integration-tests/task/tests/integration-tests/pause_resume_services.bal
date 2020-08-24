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

task:TimerConfiguration configuration = {
    intervalInMillis: 1000,
    initialDelayInMillis: 1000
};

const PAUSE_RESUME_SUCCESS_RESPONSE = "Successfully paused and resumed";
const PAUSE_RESUME_FAILURE_RESPONSE = "Pause and resume failed";

listener http:Listener timerPauseResumeListener = new (15005);

int counter1 = 0;
int counter2 = 0;

service pauseResumetimerService1 = service {
    resource function onTrigger() {
        counter1 = counter1 + 1;
    }
};

service pauseResumetimerService2 = service {
    resource function onTrigger() {
        counter2 = counter2 + 1;
    }
};

@http:ServiceConfig {
    basePath: "/"
}
service TimerHttpService on timerPauseResumeListener {
    @http:ResourceConfig {
        methods: ["GET"]
    }
    resource function getTaskPauseResumeResult(http:Caller caller, http:Request request) {
        if (counter1 > 3 && (counter2 - counter1) > 4) {
            var result = caller->respond(PAUSE_RESUME_SUCCESS_RESPONSE);
        } else {
            var result = caller->respond(PAUSE_RESUME_FAILURE_RESPONSE);
        }
    }
}

@test:Config {}
function testTaskPauseAndResume() {
    http:Client clientEndpoint = new ("http://localhost:15005");
    task:Scheduler timer1 = new (configuration);
    task:Scheduler timer2 = new (configuration);
    checkpanic timer1.attach(pauseResumetimerService1);
    checkpanic timer2.attach(pauseResumetimerService2);
    checkpanic timer1.start();
    checkpanic timer2.start();
    var result = timer1.pause();
    if (result is error) {
        return;
    }
    runtime:sleep(6000);
    result = timer1.resume();
    if (result is error) {
        return;
    }
    runtime:sleep(4000);
    var response = clientEndpoint->get("/getTaskPauseResumeResult");
    checkpanic timer1.stop();
    checkpanic timer2.stop();
    if (response is http:Response) {
        test:assertEquals(response.getTextPayload(), PAUSE_RESUME_SUCCESS_RESPONSE, msg = "Response payload mismatched");
    } else {
        test:assertFail(msg = response.message());
    }
}
