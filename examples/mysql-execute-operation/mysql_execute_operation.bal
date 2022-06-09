import ballerina/io;
import ballerinax/mysql;
import ballerina/sql;

public function main() returns error? {
    // Runs the prerequisite setup for the example.
    check initialization();

    // Initializes the MySQL client. The `mysqlClient` can be reused to access database throughout the application execution.
    mysql:Client mysqlClient = check new (user = "root",
            password = "Test@123", database = "CUSTOMER");

    float newCreditLimit = 15000.5;

    // Execute the query.
    sql:ExecutionResult result = check mysqlClient->execute(
            `UPDATE Customers SET creditLimit = ${newCreditLimit} 
            where customerId = 1`);

    // Process returned metadata.
    io:println(`Updated Row count: ${result?.affectedRowCount}`);

    // Closes the MySQL client.
    check mysqlClient.close();

    // Performs the cleanup after the example.
    check cleanup();
}

// Initializes the database as a prerequisite to the example.
function initialization() returns sql:Error? {
    mysql:Client mysqlClient = check new (user = "root", password = "Test@123");

    // Creates a database.
    _ = check mysqlClient->execute(`CREATE DATABASE CUSTOMER`);

    //Creates a table in the database.
    _ = check mysqlClient->execute(`CREATE TABLE CUSTOMER.Customers
            (customerId INTEGER NOT NULL AUTO_INCREMENT, firstName  
            VARCHAR(300), lastName  VARCHAR(300), registrationID INTEGER, 
            creditLimit DOUBLE, country VARCHAR(300),
            PRIMARY KEY (customerId))`);

    // Inserts data into the table. The result will have the `affectedRowCount`
    // and `lastInsertedId` with the auto-generated ID of the last row.
    _ = check mysqlClient->execute(`INSERT INTO CUSTOMER.Customers
            (firstName, lastName, registrationID,creditLimit,country) VALUES
            ('Peter','Stuart', 1, 5000.75, 'USA')`);
    _ = check mysqlClient->execute(`INSERT INTO CUSTOMER.Customers
            (firstName, lastName, registrationID,creditLimit,country) VALUES
            ('Dan', 'Brown', 2, 10000, 'UK')`);

    check mysqlClient.close();
}

// Cleans up the database after running the example.
function cleanup() returns sql:Error? {
    mysql:Client mysqlClient = check new (user = "root", password = "Test@123");

    // Cleans the database.
    _ = check mysqlClient->execute(`DROP DATABASE CUSTOMER`);

    // Closes the MySQL client.
    check mysqlClient.close();
}
