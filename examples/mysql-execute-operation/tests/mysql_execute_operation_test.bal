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
public isolated function mockPrint(any|error... s) {
    match counter {
        0|1|6 => {
            outputs[counter] = s[0].toString();
        }
        _ => {
            outputs[counter] = s[0].toString() + s[1].toString();
        }
    }
    counter += 1;
}

@test:Config {
    enable:false
}
function testFunc() {
    main();
    test:assertEquals(outputs[2], "Rows affected: 1");
    test:assertEquals(outputs[3], "Generated Customer ID: 1");
    test:assertEquals(outputs[4], "Updated Row count: 1");
    test:assertEquals(outputs[5], "Deleted Row count: 1");
    test:assertEquals(outputs[6], "Sample executed successfully!");
}
