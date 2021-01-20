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
    match counter {
        0 => {
            outputs[counter] = s[0].toString() + s[1].toString();
        }
        _ => {
            outputs[counter] = s[0].toString();
        }
    }
    counter += 1;
}

@test:Config {
    enable: false
}
function testFunc() {
    test:when(mock_printLn).call("mockPrint");

    main();
    test:assertEquals(outputs[0], "Error when initializing the MySQL client without any params. Error in SQL connector configuration: Failed to initialize pool: Access denied for user ''@'localhost' (using password: NO) Caused by :Access denied for user ''@'localhost' (using password: NO)");
    test:assertEquals(outputs[1], "MySQL client with user and password created.");
    test:assertEquals(outputs[2], "MySQL client with user and password created with default host.");
    test:assertEquals(outputs[3], "MySQL client with host, user, password, database and port created.");
    test:assertEquals(outputs[4], "MySQL client with database options created.");
    test:assertEquals(outputs[5], "MySQL client with connection pool created.");
    test:assertEquals(outputs[6], "Sample executed successfully!");
}
