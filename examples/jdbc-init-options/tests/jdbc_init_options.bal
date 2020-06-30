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
    outputs[counter] = s[0].toString();
    counter += 1;
}

@test:Config {}
function testFunc() {
    main();
    test:assertEquals(outputs[0], "Simple JDBC client created.");
    test:assertEquals(outputs[1], "JDBC client with user/password created.");
    test:assertEquals(outputs[2], "JDBC client with database options created.");
    test:assertEquals(outputs[3], "JDBC client with connection pool created.");
    test:assertEquals(outputs[4], "JDBC client with optional params created.");
    test:assertEquals(outputs[5], "Sample executed successfully!");
}
