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
public function mockPrint(any|error... s) {
    string output = "";
    foreach var str in s {
        output += str.toString();
    }
    outputs[counter] = output;
    counter += 1;
}

@test:Config {
    enable: false
}
function testFunc() {
    main();
    test:assertEquals(outputs[7], "\nInvoke `InsertStudent` procedure with IN params");
    test:assertEquals(outputs[8], "Call stored procedure `InsertStudent` is successful : affectedRowCount=1 lastInsertId=");
    test:assertEquals(outputs[9], "\nInvoke `GetCount` procedure with INOUT & OUT params");
    test:assertEquals(outputs[10], "Call stored procedure `GetCount` is successful.");
    test:assertEquals(outputs[11], "Age of the student with id '1' : 24");
    test:assertEquals(outputs[12], "Total student count: 1");
    test:assertEquals(outputs[13], "\nInvoke `GetStudents` procedure with returned data");
    test:assertEquals(outputs[14], "Call stored procedure `InsertStudent` is successful.");
    test:assertEquals(outputs[15], "Student details: id=1 age=24 name=George");
    test:assertEquals(outputs[16], "\nSample executed successfully!");
}
