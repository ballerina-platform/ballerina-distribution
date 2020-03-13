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
import ballerina/kubernetes;
import ballerina/openshift;

@openshift:Route {
    host: {
        domain: "127.0.0.1.nip.io"
    }
}
@kubernetes:Service { }
listener http:Listener helloEP = new(9090);

@kubernetes:Deployment {
    namespace: "bal-oc",
    registry: "192.0.0.1",
    buildImage: false,   // We do not want to create the docker image when building as the OpenShift Build Configs takes care of it.
    buildExtension: "openshift"
}
@http:ServiceConfig {
    basePath: "/helloWorld"
}
service helloWorld on helloEP {
    resource function sayHello(http:Caller outboundEP, http:Request request) {
        http:Response response = new;
        response.setTextPayload("Hello, World from service helloWorld ! \n");
        var responseResult = outboundEP->respond(response);
        if (responseResult is error) {
            log:printError("error responding back to client.", responseResult);
        }
    }
}
