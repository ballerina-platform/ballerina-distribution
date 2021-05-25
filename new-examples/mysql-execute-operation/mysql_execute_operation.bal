import ballerina/io;
import ballerinax/mysql;
import ballerina/sql;

public function main() returns error? {
    // Run the prerequisite setup for the example.
    check beforeExample();

    // Initialize the MySQL client.
    mysql:Client mysqlClient = check new (user = "root",
            password = "Test@123", database = "MYSQL_BBE");

    float newCreditLimit = 15000.5;

    // Create a parameterized query for record update.
    sql:ParameterizedQuery updateQuery = 
            `UPDATE Customers SET creditLimit = ${newCreditLimit} 
            where customerId = 1`;

    sql:ExecutionResult result = check mysqlClient -> execute(updateQuery);
    io:println("Updated Row count: ", result?.affectedRowCount);

    string firstName = "Dan";

    // Create a parameterized query for record delete.
    sql:ParameterizedQuery deleteQuery =
            `DELETE FROM Customers WHERE firstName = ${firstName}`;
    
    result = check mysqlClient -> execute(deleteQuery);
    io:println("Deleted Row count: ", result.affectedRowCount);

    // Perform cleanup after the example.
    check afterExample(mysqlClient);
}

// Initializes the database as the prerequisite to the example.
function beforeExample() returns sql:Error? {
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
function afterExample(mysql:Client mysqlClient) returns sql:Error? {
    // Clean the database.
    sql:ExecutionResult result =
            check mysqlClient -> execute(`DROP DATABASE MYSQL_BBE`);
    // Close the MySQL client.
    check mysqlClient.close();
}
