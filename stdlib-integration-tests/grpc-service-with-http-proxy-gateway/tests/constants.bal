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

import ballerina/file;

final string KEYSTORE_PATH = checkpanic file:joinPath("tests", "resources", "ballerinaKeystore.p12");
final string TRUSTSTORE_PATH = checkpanic file:joinPath("tests", "resources", "ballerinaTruststore.p12");
const string ERROR_MSG_FORMAT = "Error from Connector: %s";
const string RESP_MSG_FORMAT = "Failed: Invalid Response, expected %s, but received %s";

