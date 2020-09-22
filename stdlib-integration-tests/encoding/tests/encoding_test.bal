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

import ballerina/encoding;
import ballerina/test;

@test:Config {}
public function testEncodingAndDecodingBase64Url() {
    string input = "Ballerina Base64 URL encoding test";
    string output = "QmFsbGVyaW5hIEJhc2U2NCBVUkwgZW5jb2RpbmcgdGVzdA";
    string result = encoding:encodeBase64Url(input.toBytes());
    test:assertEquals(result, output, msg = "Unexpected base64 encoding.");

    byte[]|Error result = encoding:decodeBase64Url(output);
    if (result is byte[]) {
        byte[] expectedBytes = encodedString.toBytes();
        test:assertEquals(result, input, msg = "Unexpected base64 decoding.");
    } else {
        test:assertFail(msg = "Unexpected results from decodeBase64Url. " + result.message());
    }
}
