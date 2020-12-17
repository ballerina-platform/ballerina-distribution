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
    if (counter == 2) {
        outputs[counter] = s[0].toString() + s[1].toString();
    } else {
        outputs[counter] = s[0].toString();
    }
    counter += 1;
}

@test:Config {}
function testFunc() {
    main();
    test:assertEquals(outputs[2], "\nInsert success, generated IDs are: [1,2,3]");
    test:assertEquals(outputs[4], "[{\"affectedRowCount\":1,\"lastInsertId\":null},{\"affectedRowCount\":-3,\"lastInsertId\":null},{\"affectedRowCount\":1,\"lastInsertId\":null}]");
    test:assertEquals(outputs[5], "Rollback transaction.");
    test:assertEquals(outputs[6], "\nData in Customers table:");
    test:assertEquals(outputs[7], "{\"CUSTOMERID\":1,\"FIRSTNAME\":\"Peter\",\"LASTNAME\":\"Stuart\",\"REGISTRATIONID\":1,\"CREDITLIMIT\":5000.75,\"COUNTRY\":\"USA\"}");
    test:assertEquals(outputs[8], "{\"CUSTOMERID\":2,\"FIRSTNAME\":\"Stephanie\",\"LASTNAME\":\"Mike\",\"REGISTRATIONID\":2,\"CREDITLIMIT\":8000.0,\"COUNTRY\":\"USA\"}");
    test:assertEquals(outputs[9], "{\"CUSTOMERID\":3,\"FIRSTNAME\":\"Bill\",\"LASTNAME\":\"John\",\"REGISTRATIONID\":3,\"CREDITLIMIT\":3000.25,\"COUNTRY\":\"USA\"}");
    test:assertEquals(outputs[10], "\nSample executed successfully!");
}
