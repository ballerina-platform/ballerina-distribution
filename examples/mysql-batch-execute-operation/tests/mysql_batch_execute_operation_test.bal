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
    test:when(mock_printLn).call("mockPrint");

    main();
    test:assertEquals(outputs[3], "\nInsert success, generated IDs are: [1,2,3]\n");
    test:assertEquals(outputs[5], "[{\"affectedRowCount\":1,\"lastInsertId\":null},{\"affectedRowCount\":-3,\"lastInsertId\":null},{\"affectedRowCount\":1,\"lastInsertId\":null}]");
    test:assertEquals(outputs[6], "Rollback transaction.");
    test:assertEquals(outputs[7], "\nData in Customers table:");
    test:assertEquals(outputs[8], "{\"customerId\":1,\"firstName\":\"Peter\",\"lastName\":\"Stuart\",\"registrationID\":1,\"creditLimit\":5000.75,\"country\":\"USA\"}");
    test:assertEquals(outputs[9], "{\"customerId\":2,\"firstName\":\"Stephanie\",\"lastName\":\"Mike\",\"registrationID\":2,\"creditLimit\":8000.0,\"country\":\"USA\"}");
    test:assertEquals(outputs[10], "{\"customerId\":3,\"firstName\":\"Bill\",\"lastName\":\"John\",\"registrationID\":3,\"creditLimit\":3000.25,\"country\":\"USA\"}");
    test:assertEquals(outputs[11], "\nSample executed successfully!");
}
