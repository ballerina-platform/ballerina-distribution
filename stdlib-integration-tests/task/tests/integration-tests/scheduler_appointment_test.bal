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

listener http:Listener multipleServicesListener = new (15003);

const APPOINTMENT_MULTI_SERVICE_SUCCESS_RESPONSE = "Multiple services invoked";
const LIMITED_RUNS_SUCCESS_RESPONSE = "Scheduler triggered limited times";
const APPOINTMENT_FAILURE_RESPONSE = "Services failed to trigger";

boolean appoinmentFirstTriggered = false;
boolean appoinmentSecondTriggered = false;
int appoinmentTriggerCount1 = 0;
int appoinmentTriggerCount2 = 0;
int appoinmentTriggerCount3 = 0;

service appointmentService1 = service {
    resource function onTrigger() {
        appoinmentTriggerCount1 += 1;
        if (appoinmentTriggerCount1 > 3) {
            appoinmentFirstTriggered = true;
        }
    }
};

service appointmentService2 = service {
    resource function onTrigger() {
        appoinmentTriggerCount2 += 1;
        if (appoinmentTriggerCount2 > 3) {
            appoinmentSecondTriggered = true;
        }
    }
};

service appointmentService3 = service {
    resource function onTrigger() {
        appoinmentTriggerCount3 += 1;
    }
};

@http:ServiceConfig {
    basePath: "/"
}
service MultipleServiceListener on multipleServicesListener {
    @http:ResourceConfig {
        methods: ["GET"]
    }
    resource function getMultipleServiceResult(http:Caller caller, http:Request request) {
        if (appoinmentFirstTriggered && appoinmentSecondTriggered) {
            var result = caller->respond(APPOINTMENT_MULTI_SERVICE_SUCCESS_RESPONSE);
        } else {
            var result = caller->respond(APPOINTMENT_FAILURE_RESPONSE);
        }
    }

    @http:ResourceConfig {
        methods: ["GET"]
    }
    resource function getLimitedNumberOfRunsResult(http:Caller caller, http:Request request) {
        // Sleep for 5 seconds, as the scheduler is scheduled to run every second, for only three times.
        // Hence it should make count3 = 3, and then stop, after 3 seconds it was started.
        // We wait 5 seconds so that to confirm it did not ran more than 3 times.
        runtime:sleep(5000);
        if (appoinmentTriggerCount3 == 3) {
            var result = caller->respond(LIMITED_RUNS_SUCCESS_RESPONSE);
        } else {
            var result = caller->respond(APPOINTMENT_FAILURE_RESPONSE);
        }
    }
}

@test:Config {}
function testSchedulerWithMultipleServices() {
    http:Client multipleAttachmentClientEndpoint = new ("http://localhost:15003");
    string cronExpression = "* * * * * ? *";
    task:Scheduler appointment = new ({appointmentDetails: cronExpression});

    checkpanic appointment.attach(appointmentService1);
    checkpanic appointment.attach(appointmentService2);
    checkpanic appointment.start();
    runtime:sleep(4000);
    var response = multipleAttachmentClientEndpoint->get("/getMultipleServiceResult");
    checkpanic appointment.stop();
    if (response is http:Response) {
        test:assertEquals(response.getTextPayload(), MULTI_SERVICE_SUCCESS_RESPONSE, msg = "Response payload mismatched");
    } else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {}
function testLimitedNumberOfRuns() {
    http:Client multipleAttachmentClientEndpoint = new ("http://localhost:15003");
    string cronExpression = "* * * * * ? *";
    task:AppointmentConfiguration configuration = {
        appointmentDetails: cronExpression,
        noOfRecurrences: 3
    };

    task:Scheduler appointmentWithLimitedRuns = new (configuration);
    var result = appointmentWithLimitedRuns.attach(appointmentService3);
    checkpanic appointmentWithLimitedRuns.start();
    var response = multipleAttachmentClientEndpoint->get("/getLimitedNumberOfRunsResult");
    checkpanic appointmentWithLimitedRuns.stop();
    if (response is http:Response) {
        test:assertEquals(response.getTextPayload(), LIMITED_RUNS_SUCCESS_RESPONSE, msg = "Response payload mismatched");
    } else {
        test:assertFail(msg = response.message());
    }
}
