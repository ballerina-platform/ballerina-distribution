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

import ballerina/test;
import ballerina/url;

@test:Config {}
public function testUrlEncodingAndDecoding() {
    string input = "http://localhost:9090/echoService?type=string&value=hello world";
    string output = "http%3A%2F%2Flocalhost%3A9090%2FechoService%3Ftype%3Dstring%26value%3Dhello%20world";
    string|url:Error encodedResult = url:encode(input, "UTF-8");
    if (encodedResult is string) {
        test:assertEquals(encodedResult, output);
    } else {
        test:assertFail(msg = "Test Failed!");
    }

    string|url:Error decodedResult = url:decode(<string>output, "UTF-8");
    if (decodedResult is string) {
        test:assertEquals(decodedResult, input);
    } else {
        test:assertFail(msg = "Test Failed!");
    }
}
