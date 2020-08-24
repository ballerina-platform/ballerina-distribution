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

const MULTI_SERVICE_SUCCESS_RESPONSE = "Multiple services invoked";
const MULTI_SERVICE_FAILURE_RESPONSE = "Services failed to trigger";

boolean firstTriggered = false;
boolean secondTriggered = false;

string result = "";

int count1 = 0;
int count2 = 0;

public type Person record {
    string name;
    int age;
};

listener http:Listener taskAttachmentListener = new (15004);

service timerService1 = service {
    resource function onTrigger(Person person) {
        person.age = person.age + 1;
        result = <@untainted string>(person.name + " is " + person.age.toString() + " years old");
    }
};

service service1 = service {
    resource function onTrigger() {
        count1 = count1 + 1;
        if (count1 > 3) {
            firstTriggered = true;
        }
    }
};

service service2 = service {
    resource function onTrigger() {
        count2 = count2 + 1;
        if (count2 > 3) {
            secondTriggered = true;
        }
    }
};

@http:ServiceConfig {
    basePath: "/"
}
service TimerAttachmentHttpService on taskAttachmentListener {
    @http:ResourceConfig {
        methods: ["GET"]
    }
    resource function getTaskAttachmentResult(http:Caller caller, http:Request request) {
        var sendResult = caller->respond(result);
    }

    @http:ResourceConfig {
        methods: ["GET"]
    }
    resource function getMultipleServicesResult(http:Caller caller, http:Request request) {
        if (firstTriggered && secondTriggered) {
            var result = caller->respond(MULTI_SERVICE_SUCCESS_RESPONSE);
        } else {
            var result = caller->respond(MULTI_SERVICE_FAILURE_RESPONSE);
        }
    }
}

@test:Config {}
function testTaskTimerWithAttachment() {
    Person person = {
        name: "Sam",
        age: 0
    };

    http:Client taskTimerClientEndpoint1 = new ("http://localhost:15004");
    task:Scheduler taskTimer = new ({intervalInMillis: 1000, initialDelayInMillis: 1000, noOfRecurrences: 5});
    var attachResult = taskTimer.attach(timerService1, person);
    if (attachResult is task:SchedulerError) {
        panic attachResult;
    }
    var startResult = taskTimer.start();
    if (startResult is task:SchedulerError) {
        panic startResult;
    }
    // Sleep for 8 seconds to check whether the task is running for more than 5 times.
    runtime:sleep(8000);
    var response = taskTimerClientEndpoint1->get("/getTaskAttachmentResult");
    checkpanic taskTimer.stop();
    if (response is http:Response) {
        test:assertEquals(response.getTextPayload(), "Sam is 5 years old", msg = "Response payload mismatched");
    } else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {}
function testTaskTimerWithMultipleServices() {
    http:Client taskTimerClientEndpoint2 = new ("http://localhost:15004");
    task:Scheduler timerWithMultipleServices = new ({intervalInMillis: 1000});
    checkpanic timerWithMultipleServices.attach(service1);
    checkpanic timerWithMultipleServices.attach(service2);
    checkpanic timerWithMultipleServices.start();
    runtime:sleep(4000);
    var response = taskTimerClientEndpoint2->get("/getMultipleServicesResult");
    checkpanic timerWithMultipleServices.stop();
    if (response is http:Response) {
        test:assertEquals(response.getTextPayload(), MULTI_SERVICE_SUCCESS_RESPONSE, msg = "Response payload mismatched");
    } else {
        test:assertFail(msg = response.message());
    }
}
