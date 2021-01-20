// Copyright (c) 2020, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied. See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/sql;
import ballerinax/mysql;
import ballerina/test;

string host = "localhost";
string mysqlUser = "root";
string mysqlPassword = "Test123#";
int port = 3305;
string connectDB = "CONNECT_DB";

@test:Config {
}
function testConnectionWithNoFields() {
    mysql:Client|sql:Error dbClient = new ();
    test:assertTrue(dbClient is sql:Error, "Initialising connection with no fields should fail.");
}

@test:Config {
}
function testWithURLParams() {
    mysql:Client|sql:Error dbClient = new (host, mysqlUser, mysqlPassword, connectDB, port);
    if (dbClient is sql:Error) {
        test:assertExactEquals(dbClient.message(),
            "Error in SQL connector configuration: java.lang.ClassNotFoundException: " +
            "com.mysql.cj.jdbc.MysqlDataSource Caused by :com.mysql.cj.jdbc.MysqlDataSource");
    } else {
        test:assertFail("Should throw an error because connector is missing.");
    }
}
