import ballerina/io;
import ballerinax/mysql;
import ballerina/sql;

public function main() returns error? {
    // Runs the prerequisite setup for the example.
    check initialize();

    // Initializes the MySQL client. The `mysqlClient` can be reused to access database throughout the application execution.
    mysql:Client mysqlClient = check new (user = "root",
            password = "Test@123", database = "CUSTOMER");

    // The records to be inserted.
    var customers = [
        {
            firstName: "Peter",
            lastName: "Stuart",
            registrationID: 1,
            creditLimit: 5000.75,
            country: "USA"
        },
        {
            firstName: "Stephanie",
            lastName: "Mike",
            registrationID: 2,
            creditLimit: 8000.00,
            country: "USA"
        },
        {
            firstName: "Bill",
            lastName: "John",
            registrationID: 3,
            creditLimit: 3000.25,
            country: "USA"
        }
    ];

    // Creates a batch parameterized query.
    sql:ParameterizedQuery[] insertQueries =
        from var customer in customers
        select `INSERT INTO Customers
                (firstName, lastName, registrationID, creditLimit, country)
                VALUES (${customer.firstName}, ${customer.lastName},
                ${customer.registrationID}, ${customer.creditLimit}, 
                ${customer.country})`;

    // Inserts the records with the auto-generated ID.
    sql:ExecutionResult[] result =
                            check mysqlClient->batchExecute(insertQueries);

    int[] generatedIds = [];
    foreach var summary in result {
        generatedIds.push(<int>summary.lastInsertId);
    }
    io:println(`Insert success, generated IDs are: ${generatedIds}`);

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
            (customerId INTEGER NOT NULL AUTO_INCREMENT,
            firstName VARCHAR(300), lastName  VARCHAR(300),
            registrationID INTEGER, creditLimit DOUBLE,
            country  VARCHAR(300), PRIMARY KEY (customerId))`);

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
