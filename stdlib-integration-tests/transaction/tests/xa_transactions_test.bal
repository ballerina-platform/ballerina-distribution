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

import ballerina/config;
import ballerina/jdbc;
import ballerina/test;

string xaDatasourceName = "org.h2.jdbcx.JdbcDataSource";

@test:Config {
    before: addConfigs
}
function testXATransactions() returns error? {
    string str = "";

    jdbc:Client dbClient1 = check new (url = "jdbc:h2:file:./xa-transactions/testdb1",
                            user = "test", password = "test", options = {datasourceName: xaDatasourceName});

    jdbc:Client dbClient2 = check new (url = "jdbc:h2:file:./xa-transactions/testdb2",
                            user = "test", password = "test", options ={datasourceName: xaDatasourceName});

    _ = check dbClient1->execute("CREATE TABLE IF NOT EXISTS EMPLOYEE " +
                                  "(ID INT, NAME VARCHAR(30))");
    _ = check dbClient2->execute("CREATE TABLE IF NOT EXISTS SALARY " +
                                 "(ID INT, VALUE FLOAT)");

    transaction {
        str += "transaction started";

        var e1 = check dbClient1->execute("INSERT INTO EMPLOYEE(NAME) VALUES ('Anne')");
        var e2 = check dbClient2->execute("INSERT INTO SALARY VALUES (1, 25000.00)");

        var commitResult = commit;
        if commitResult is () {
            str += " -> transaction committed";
        } else {
            str += " -> transaction failed";
        }
        str += " -> transaction ended.";
    }

    test:assertEquals("transaction started -> transaction committed -> transaction ended.", str);

    checkpanic dbClient1.close();
    checkpanic dbClient2.close();
}

function addConfigs() {
    config:setConfig("b7a.transaction.log.base", "trxLogDir");
    config:setConfig("b7a.transaction.manager.enabled", true);
}
