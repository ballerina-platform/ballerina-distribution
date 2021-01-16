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

type HttpResponseDetails record {
    int statusCode;
    string responseMessage;
};

map<(anydata|error)> outputs = {};

public function storeOutput(string key, any|error... s) {
    any|error statusCode = s[0];
    outputs[key] = statusCode is error ? statusCode.toString() : statusCode.toString();
}

public function fetchOutput(string key) returns (anydata|error) {
    return outputs[key];
}

function fetchHttpResponse(http:Response|http:PayloadType|error response) returns HttpResponseDetails {
    string responseMessage = "";
    int statusCode = -1;
    if (response is http:Response) {
        statusCode = response.statusCode;
        var msg = response.getTextPayload();
        if (msg is string) {
            responseMessage = msg;
        } else {
            responseMessage = "Invalid payload received";
        }
    } else {
        responseMessage = "Error when calling the backend";
    }
    HttpResponseDetails httpResponseDetails = {
        statusCode: statusCode,
        responseMessage: responseMessage
    };
    return httpResponseDetails;
}

