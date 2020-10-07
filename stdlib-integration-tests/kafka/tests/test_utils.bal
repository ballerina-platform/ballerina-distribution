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

import ballerina/system;

function createKafkaCluster(string directory, string yamlFilePath) returns error? {
    var result = system:exec("docker-compose", {}, directory, "-f", yamlFilePath, "up", "-d");
    if (result is error) {
        return error("Error occurred while creating the Kafka server");
    }
    system:Process dockerProcess = <system:Process>result;
    var processResult = dockerProcess.waitForExit();
    if (processResult is error) {
        return processResult;
    } else {
        if (processResult != 0) {
            return error("Process exited with non-zero value: " + processResult.toString());
        }
    }
}

function stopKafkaCluster(string directory, string yamlFilePath) returns error? {
    var result = system:exec("docker-compose", {}, directory, "-f", yamlFilePath, "rm", "-svf");
    if (result is error) {
        return result;
    }
    system:Process dockerProcess = <system:Process>result;
    var processResult = dockerProcess.waitForExit();
    if (processResult is error) {
        return processResult;
    } else {
        if (processResult != 0) {
            return error("Process exited with non-zero value: " + processResult.toString());
        }
    }
}
