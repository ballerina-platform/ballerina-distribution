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

string[] outputs = [];
int counter = 0;

@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
test:MockFunction mock_printLn = new();

public function mockPrint(any|error... s) {
    outputs[counter] = s[0].toString();
    counter += 1;
}

@test:Config {
    enable: false
}
function testFunc() {
    test:when(mock_printLn).call("mockPrint");

    main();
    test:assertEquals(outputs[0], "------ Query Binary Type -------");
    test:assertEquals(outputs[1], "Result 1:");
    test:assertEquals(outputs[2], "{\"row_id\":1,\"blob_type\":[119,115,111,50,32,98,97,108,108,101,114,105,110,97,32,98,108,111,98,32,116,101,115,116,46],\"binary_type\":[119,115,111,50,32,98,97,108,108,101,114,105,110,97,32,98,105,110,97,114,121,32,116,101,115,116,46]}");
    test:assertEquals(outputs[3], "Result 2:");
    test:assertEquals(outputs[4], "{\"row_id\":1,\"blob_type\":[119,115,111,50,32,98,97,108,108,101,114,105,110,97,32,98,108,111,98,32,116,101,115,116,46],\"binary_type\":[119,115,111,50,32,98,97,108,108,101,114,105,110,97,32,98,105,110,97,114,121,32,116,101,115,116,46]}");
    test:assertEquals(outputs[5], "------ ********* -------");
    test:assertEquals(outputs[6], "------ Query Date Time Type -------");
    test:assertEquals(outputs[7], "Result 1:");
    test:assertEquals(outputs[9], "Result 2:");
    test:assertEquals(outputs[11], "------ ********* -------");
    test:assertEquals(outputs[12], "Sample executed successfully!");
}
