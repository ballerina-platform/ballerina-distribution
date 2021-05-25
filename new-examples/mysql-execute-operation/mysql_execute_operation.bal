import ballerina/io;
import ballerinax/mysql;
import ballerina/sql;

function updateRecord(mysql:Client mysqlClient) returns sql:Error? {
    float newCreditLimit = 15000.5;

    // Create a parameterized query for record update.
    sql:ParameterizedQuery updateQuery = 
            `UPDATE Customers SET creditLimit = ${newCreditLimit} 
            where customerId = 1`;

    sql:ExecutionResult result = check mysqlClient -> execute(updateQuery);
    io:println("Updated Row count: ", result?.affectedRowCount);
}

function deleteRecord(mysql:Client mysqlClient) returns sql:Error? {
    string firstName = "Dan";

    // Create a parameterized query for record delete.
    sql:ParameterizedQuery deleteQuery =
            `DELETE FROM Customers WHERE firstName = ${firstName}`;
    sql:ExecutionResult result = check mysqlClient -> execute(deleteQuery);
    io:println("Deleted Row count: ", result.affectedRowCount);
}

// Initializes the database as the prerequisite to the example.
function beforeRunningExample() returns sql:Error? {
    mysql:Client mysqlClient = check new (user = "root", password = "Test@123");

    // Create a Database.
    sql:ExecutionResult result =
        check mysqlClient -> execute(`CREATE DATABASE MYSQL_BBE`);

    //Create a table in the database.
    result = check mysqlClient -> execute(`CREATE TABLE MYSQL_BBE.Customers
            (customerId INTEGER NOT NULL AUTO_INCREMENT, firstName  
            VARCHAR(300), lastName  VARCHAR(300), registrationID INTEGER, 
            creditLimit DOUBLE, country  VARCHAR(300),PRIMARY KEY (customerId))`);

    // Insert data into the table. The result will have `affectedRowCount`
    // and `lastInsertedId` with the auto-generated ID of the last row.
    result = check mysqlClient -> execute(`INSERT INTO MYSQL_BBE.Customers (firstName,
            lastName, registrationID,creditLimit,country) VALUES ('Peter',
            'Stuart', 1, 5000.75, 'USA')`);
    result = check mysqlClient -> execute(`INSERT INTO MYSQL_BBE.Customers (firstName,
            lastName, registrationID,creditLimit,country) VALUES ('Dan', 'Brown',
            2, 10000, 'UK')`);

    io:println("Rows affected: ", result.affectedRowCount);
    io:println("Generated Customer ID: ", result.lastInsertId);  

    check mysqlClient.close();      
}

// Cleans up the database after running the example.
function afterRunningExample(mysql:Client mysqlClient) returns sql:Error? {
    // Clean the database.
    sql:ExecutionResult result =
            check mysqlClient -> execute(`DROP DATABASE MYSQL_BBE`);
    // Close the MySQL client.
    check mysqlClient.close();
}

public function main() returns error? {
    // Run the prerequisite setup for the example.
    check beforeRunningExample();

    // Initialize the MySQL client.
    mysql:Client mysqlClient = check new (user = "root",
            password = "Test@123", database = "MYSQL_BBE");

    // Update a record.
    check updateRecord(mysqlClient);

    // Delete a record.
    check deleteRecord(mysqlClient);

    // Perform cleanup after the example.
    check afterRunningExample(mysqlClient);
}
