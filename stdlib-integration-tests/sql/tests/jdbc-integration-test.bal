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
import ballerina/java.jdbc;
import ballerina/filepath;
import ballerina/test;

string user = "test";
string password = "Test123";

string dbPath = checkpanic filepath:absolute("target/databases");
string jdbcUrl = "jdbc:h2:" + dbPath + "/" + "CONNECT_DB";

@test:Config {
}
function testConnection1() {
    jdbc:Client testDB = checkpanic new (url = jdbcUrl, user = user, password = password);
    test:assertEquals(testDB.close(), (), "JDBC connection failure.");
}

@test:Config {
}
function testConnection2() {
    jdbc:Client testDB = checkpanic new (jdbcUrl, user, password);
    test:assertEquals(testDB.close(), (), "JDBC connection failure.");
}


@test:Config {
}
function testConnectionInvalidUrl() {
    string invalidUrl = "jdbc:h3:";
    jdbc:Client|sql:Error dbClient = new (invalidUrl);
    if (!(dbClient is sql:Error)) {
        checkpanic dbClient.close();
        test:assertFail("Invalid does not throw DatabaseError");
    }
}

@test:Config {
}
function testConnectionNoUserPassword() {
    jdbc:Client|sql:Error dbClient = new (jdbcUrl);
    if (!(dbClient is sql:Error)) {
        checkpanic dbClient.close();
        test:assertFail("No username does not throw DatabaseError");
    }
}

@test:Config {
}
function testConnectionWithValidDriver() {
    jdbc:Client|sql:Error dbClient = new (jdbcUrl, user, password, {datasourceName: "org.h2.jdbcx.JdbcDataSource"});
    if (dbClient is sql:Error) {
        test:assertFail("Valid driver throws DatabaseError");
    } else {
        checkpanic dbClient.close();
    }
}

@test:Config {
}
function testConnectionWithInvalidDriver() {
    jdbc:Client|sql:Error dbClient = new (jdbcUrl, user, password,
        {datasourceName: "org.h2.jdbcx.JdbcDataSourceInvalid"});
    if (!(dbClient is sql:Error)) {
        checkpanic dbClient.close();
        test:assertFail("Invalid driver does not throw DatabaseError");
    }
}

@test:Config {
}
function testConnectionWithDatasourceOptions() {
    jdbc:Options options = {
        datasourceName: "org.h2.jdbcx.JdbcDataSource",
        properties: {"loginTimeout": 5000}
    };
    jdbc:Client|sql:Error dbClient = new (jdbcUrl, user, password, options);
    if (dbClient is sql:Error) {
        test:assertFail("Datasource options throws DatabaseError");
    } else {
        checkpanic dbClient.close();
    }
}

@test:Config {
}
function testConnectionWithDatasourceInvalidProperty() {
    jdbc:Options options = {
        datasourceName: "org.h2.jdbcx.JdbcDataSource",
        properties: {"invalidProperty": 109}
    };
    jdbc:Client|sql:Error dbClient = new (jdbcUrl, user, password, options);
    if (dbClient is sql:Error) {
        test:assertEquals(dbClient.message(), "Error in SQL connector configuration: Property invalidProperty " +
        "does not exist on target class org.h2.jdbcx.JdbcDataSource");
    } else {
        checkpanic dbClient.close();
        test:assertFail("Invalid driver does not throw DatabaseError");
    }
}

@test:Config {
}
function testWithConnectionPool() {
    sql:ConnectionPool connectionPool = {
        maxOpenConnections: 25
    };
    jdbc:Client dbClient = checkpanic new (url = jdbcUrl, user = user,
        password = password, connectionPool = connectionPool);
    error? err = dbClient.close();
    if (err is error) {
        test:assertFail("DB connection not created properly.");
    } else {
        test:assertEquals(connectionPool.maxConnectionLifeTimeInSeconds, <decimal> 1800);
        test:assertEquals(connectionPool.minIdleConnections, 15);
    }
}

@test:Config {
}
function testWithSharedConnPool() {
    sql:ConnectionPool connectionPool = {
        maxOpenConnections: 25
    };
    jdbc:Client dbClient1 = checkpanic new (url = jdbcUrl, user = user,
        password = password, connectionPool = connectionPool);
    jdbc:Client dbClient2 = checkpanic new (url = jdbcUrl, user = user,
        password = password, connectionPool = connectionPool);
    jdbc:Client dbClient3 = checkpanic new (url = jdbcUrl, user = user,
        password = password, connectionPool = connectionPool);

    test:assertEquals(dbClient1.close(), (), "JDBC connection failure.");
    test:assertEquals(dbClient2.close(), (), "JDBC connection failure.");
    test:assertEquals(dbClient3.close(), (), "JDBC connection failure.");
}

@test:Config {
}
function testWithAllParams() {
    jdbc:Options options = {
        datasourceName: "org.h2.jdbcx.JdbcDataSource",
        properties: {"loginTimeout": 5000}
    };
    sql:ConnectionPool connectionPool = {
        maxOpenConnections: 25
    };
    jdbc:Client dbClient = checkpanic new (jdbcUrl, user, password, options, connectionPool);
    test:assertEquals(dbClient.close(), (), "JDBC connection failure.");
}
