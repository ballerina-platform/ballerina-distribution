import ballerina/io;
import ballerina/log;
import ballerinax/mysql;
import ballerina/sql;

public function main() returns error? {
    // Runs the prerequisite setup for the example.
    check initialization();

    // Initializes the MySQL client. The `mysqlClient` can be reused to access database throughout the application execution.
    mysql:Client mysqlClient = check new (user = "root", 
            password = "Test@123", database = "CUSTOMER");

    // Records with the duplicate `registrationID` entry. Here it is `registrationID` = 1.
    var customers = [
        {
            firstName: "Linda",
            lastName: "Jones",
            registrationID: 4,
            creditLimit: 10000.75,
            country: "USA"
        }, 
        {
            firstName: "Peter",
            lastName: "Stuart",
            registrationID: 1,
            creditLimit: 5000.75,
            country: "USA"
        }, 
        {
            firstName: "Camellia",
            lastName: "Potter",
            registrationID: 5,
            creditLimit: 2000.25,
            country: "USA"
        }
    ];

    // Creates a batch parameterized query.
    sql:ParameterizedQuery[] insertQueries = 
        from var customer in customers
        select `INSERT INTO Customers
                (firstName, lastName, registrationID, creditLimit, country)
                VALUES (${customer.firstName}, ${customer.lastName},
                ${customer.registrationID}, ${customer.creditLimit}, ${customer.country})`;

    // The transaction block can be used to roll back if any error occurred.
    transaction {
        sql:ExecutionResult[]|sql:Error result = mysqlClient->batchExecute(insertQueries);
        if result is sql:BatchExecuteError {
            io:println(result.message());
            io:println(result.detail()?.executionResults);
            io:println("Rollback transaction.");
            rollback;
        } else {
            error? err = commit;
            if err is error {
                log:printError("Error occurred while committing", err);
            }
        }
    }

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

    // Creates a table in the database.
    _ = check mysqlClient->execute(`CREATE TABLE CUSTOMER.Customers
            (customerId INTEGER NOT NULL AUTO_INCREMENT,
            firstName VARCHAR(300), lastName  VARCHAR(300), registrationID
            INTEGER UNIQUE, creditLimit DOUBLE, country  VARCHAR(300),
            PRIMARY KEY (customerId))`);

    // Adds records to the newly-created table.
    _ = check mysqlClient->execute(`INSERT INTO CUSTOMER.Customers
            (firstName, lastName, registrationID,creditLimit,country) VALUES
             ('Peter', 'Stuart', 1, 5000.75, 'USA')`);

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
