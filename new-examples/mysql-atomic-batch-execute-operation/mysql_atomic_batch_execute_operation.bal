import ballerina/io;
import ballerinax/mysql;
import ballerina/sql;

public function main() returns error? {
    // Run the prerequisite setup for the example.
    check beforeExample();

    // Initialize the MySQL client.
    mysql:Client mysqlClient = check new (user = "root",
            password = "Test@123", database = "MYSQL_BBE");

    // Records with duplicate `registrationID` entry (registrationID = 1).
    var insertRecords = [
        {firstName: "Linda", lastName: "Jones", registrationID: 4,
                                    creditLimit: 10000.75, country: "USA"},
        {firstName: "Peter", lastName: "Stuart", registrationID: 1,
                                    creditLimit: 5000.75, country: "USA"},
        {firstName: "Camellia", lastName: "Potter", registrationID: 5,
                                    creditLimit: 2000.25, country: "USA"}
    ];

    // Create a batch Parameterized Query.
    sql:ParameterizedQuery[] insertQueries =
        from var data in insertRecords
            select  `INSERT INTO Customers
                (firstName, lastName, registrationID, creditLimit, country)
                VALUES (${data.firstName}, ${data.lastName},
                ${data.registrationID}, ${data.creditLimit}, ${data.country})`;

    // Transaction block can be used to rollback if any error occurred.
    transaction {
        var result = mysqlClient -> batchExecute(insertQueries);
        if result is sql:BatchExecuteError {
            io:println(result.message());
            io:println(result.detail()?.executionResults);
            io:println("Rollback transaction.\n");
            rollback;
        } else {
            error? err = commit;
            if err is error {
                io:println("Error occurred while committing: ", err);
            }
        }
    }

    // Check the data after batch execute.
    stream<record{}, error> resultStream =
        mysqlClient -> query("SELECT * FROM Customers");

    io:println("Data in Customers table:");
    error? e = resultStream.forEach(function(record {} result) {
                 io:println(result.toString());
    });

    // Perform cleanup after the example.
    check afterExample(mysqlClient);
}

// Initializes the database as the prerequisite to the example.
function beforeExample() returns sql:Error? {
    mysql:Client mysqlClient = check new (user = "root", password = "Test@123");

    // Create a Database.
    sql:ExecutionResult result =
        check mysqlClient -> execute(`CREATE DATABASE MYSQL_BBE`);

    // Create a table in the database.
    result = check mysqlClient -> execute(`CREATE TABLE MYSQL_BBE.Customers
            (customerId INTEGER NOT NULL AUTO_INCREMENT, firstName  VARCHAR(300), 
            lastName  VARCHAR(300), registrationID INTEGER UNIQUE, creditLimit DOUBLE, 
            country  VARCHAR(300), PRIMARY KEY (customerId))`);

    // Add records to the newly created table.
    result = check mysqlClient -> execute(`INSERT INTO MYSQL_BBE.Customers (firstName,
            lastName, registrationID,creditLimit,country) VALUES ('Peter',
            'Stuart', 1, 5000.75, 'USA')`);

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
