import ballerina/io;
import ballerinax/mysql;
import ballerina/sql;

// Defines a record to load the query result.
type Customer record {|
    int customerId;
    string lastName;
    string firstName;
    int registrationId;
    float creditLimit;
    string country;
|};

public function main() returns error? {
    // Runs the prerequisite setup for the example.
    check initialize();

    // Initializes the MySQL client. The `mysqlClient` can be reused to access the database throughout the application execution.
    mysql:Client mysqlClient = check new (user = "root",
            password = "Test@123", database = "CUSTOMER");

    float creditLimit = 5000;

    // Query table with a condition.
    stream<Customer, error?> resultStream =
            mysqlClient->query(`SELECT * FROM Customers
                                WHERE creditLimit > ${creditLimit};`);

    // Iterates the result stream.
    check from Customer customer in resultStream
        do {
            io:println(`Customer Details: ${customer}`);
        };

    // Closes the stream to release the resources.
    check resultStream.close();

    // Closes the MySQL client.
    check mysqlClient.close();

    // Performs the cleanup after the example.
    check cleanup();
}

// Initializes the database as a prerequisite to the example.
function initialize() returns sql:Error? {
    mysql:Client mysqlClient = check new (user = "root", password = "Test@123");

    // Creates a database.
    _ = check mysqlClient->execute(`CREATE DATABASE CUSTOMER`);

    // Creates a table in the database.
    _ = check mysqlClient->execute(`CREATE TABLE CUSTOMER.Customers
            (customerId INTEGER NOT NULL AUTO_INCREMENT, firstName
            VARCHAR(300), lastName  VARCHAR(300), registrationID INTEGER,
            creditLimit DOUBLE, country  VARCHAR(300),
            PRIMARY KEY (customerId))`);

    // Adds the records to the newly-created table.
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

    check mysqlClient.close();
}
