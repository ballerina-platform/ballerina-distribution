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

import ballerina/io;
import ballerina/test;

// Client endpoint configuration with SSL configurations.
HelloWorldBlockingClient helloWorldBlockingEp = new("https://localhost:20004", {
    secureSocket: {
        cert: {
            path: TRUSTSTORE_PATH,
            password: "ballerina"
        }
    }
});

@test:Config {}
function testSecuredUnaryService() {
    // Executes unary blocking secured call.
    var unionResp = helloWorldBlockingEp->hello("WSO2");
    if (unionResp is error) {
        test:assertFail(string `Error from Connector: ${unionResp.message()}`);
    } else {
        string result;
        [result, _] = unionResp;
        string expected = "Hello WSO2";
        test:assertEquals(result, expected);
    }
}
