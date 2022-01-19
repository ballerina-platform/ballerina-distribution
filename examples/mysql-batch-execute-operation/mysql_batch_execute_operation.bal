import ballerina/io;
import ballerinax/mysql;
import ballerina/sql;

public function main() returns error? {
    // Runs the prerequisite setup for the example.
    check beforeExample();

    // Initializes the MySQL client.
    mysql:Client mysqlClient = check new (user = "root", 
            password = "Test@123", database = "MYSQL_BBE");

    // The records to be inserted.
    var insertRecords = [
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
        from var data in insertRecords
        select `INSERT INTO Customers
                (firstName, lastName, registrationID, creditLimit, country)
                VALUES (${data.firstName}, ${data.lastName},
                ${data.registrationID}, ${data.creditLimit}, ${data.country})`;

    // Inserts the records with the auto-generated ID.
    sql:ExecutionResult[] result = 
                            check mysqlClient->batchExecute(insertQueries);

    int[] generatedIds = [];
    foreach var summary in result {
        generatedIds.push(<int>summary.lastInsertId);
    }
    io:println("\nInsert success, generated IDs are: ", generatedIds, "\n");

    // Checks the data after the batch execution.
    stream<record {}, error?> resultStream =
        mysqlClient->query(`SELECT * FROM Customers`);

    io:println("Data in Customers table:");
    check from record {} resultRecord in resultStream
        do {
            io:println(resultRecord.toString());
        };

    // Performs the cleanup after the example.
    check afterExample(mysqlClient);
}

// Initializes the database as a prerequisite to the example.
function beforeExample() returns sql:Error? {
    mysql:Client mysqlClient = check new (user = "root", password = "Test@123");

    // Creates a database.
    _ = check mysqlClient->execute(`CREATE DATABASE MYSQL_BBE`);

    // Creates a table in the database.
    _ = check mysqlClient->execute(`CREATE TABLE MYSQL_BBE.Customers
            (customerId INTEGER NOT NULL AUTO_INCREMENT,
            firstName VARCHAR(300), lastName  VARCHAR(300),
            registrationID INTEGER, creditLimit DOUBLE,
            country  VARCHAR(300), PRIMARY KEY (customerId))`);

    check mysqlClient.close();
}

// Cleans up the database after running the example.
function afterExample(mysql:Client mysqlClient) returns sql:Error? {
    // Cleans the database.
    _ = check mysqlClient->execute(`DROP DATABASE MYSQL_BBE`);

    // Closes the MySQL client.
    check mysqlClient.close();
}
