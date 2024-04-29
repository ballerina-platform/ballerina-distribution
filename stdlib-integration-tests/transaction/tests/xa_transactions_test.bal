// Copyright (c) 2020-2024, WSO2 LLC. (https://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
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

import ballerina/sql;
import ballerina/test;

import ballerinax/java.jdbc;

string xaDatasourceName = "org.h2.jdbcx.JdbcDataSource";

@test:Config {
}
function testXATransactions() returns error? {
    string str = "";

    jdbc:Client dbClient1 = check new (url = "jdbc:h2:file:./xa-transactions/testdb1",
        user = "test", password = "test", options = {datasourceName: xaDatasourceName}
    );

    jdbc:Client dbClient2 = check new (url = "jdbc:h2:file:./xa-transactions/testdb2",
        user = "test", password = "test", options = {datasourceName: xaDatasourceName}
    );

    _ = check dbClient1->execute(`CREATE TABLE IF NOT EXISTS EMPLOYEE (ID INT, NAME VARCHAR(30))`);
    _ = check dbClient2->execute(`CREATE TABLE IF NOT EXISTS SALARY (ID INT, "VALUE" FLOAT)`);

    transaction {
        str += "transaction started";

        _ = check dbClient1->execute(`INSERT INTO EMPLOYEE VALUES (1, 'John')`);
        _ = check dbClient2->execute(`INSERT INTO SALARY VALUES (1, 20000.00)`);

        var commitResult = commit;
        if commitResult is () {
            str += " -> transaction committed";
        } else {
            str += " -> transaction failed";
        }
        str += " -> transaction ended.";
    }

    test:assertEquals(str, "transaction started -> transaction committed -> transaction ended.");

    // Verify that the data was inserted successfully to both databases
    sql:ExecutionResult employeeResult = check dbClient1->queryRow(`SELECT * FROM EMPLOYEE WHERE ID = 1`);
    sql:ExecutionResult salaryResult = check dbClient2->queryRow(`SELECT * FROM SALARY WHERE ID = 1`);
    json employeeResultJson = employeeResult.toJson();
    json salaryResultJson = salaryResult.toJson();

    test:assertEquals(employeeResultJson.ID, 1);
    test:assertEquals(employeeResultJson.NAME, "John");
    test:assertEquals(salaryResultJson.ID, 1);
    test:assertEquals(salaryResultJson.VALUE, 20000.00);

    checkpanic dbClient1.close();
    checkpanic dbClient2.close();
}
