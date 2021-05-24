import ballerina/io;
import ballerinax/java.jdbc;
import ballerina/sql;

function simulateBatchExecuteFailure(jdbc:Client jdbcClient) returns sql:Error? {
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
        var result = jdbcClient -> batchExecute(insertQueries);
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
}

function tableInspectAfterBatchExecute(jdbc:Client jdbcClient) returns sql:Error? {
    stream<record{}, error> resultStream =
        jdbcClient -> query("SELECT * FROM Customers");

    io:println("Data in Customers table:");
    error? e = resultStream.forEach(function(record {} result) {
                 io:println(result.toString());
    });
}

// Initializes the database as the prerequisite to the example.
function beforeRunningExample(jdbc:Client jdbcClient) returns sql:Error? {
    // Create a table in the database.
    sql:ExecutionResult result =
        check jdbcClient -> execute(`CREATE TABLE Customers(customerId INTEGER
            NOT NULL IDENTITY, firstName  VARCHAR(300), lastName  VARCHAR(300),
            registrationID INTEGER UNIQUE, creditLimit DOUBLE, country  VARCHAR(300),
            PRIMARY KEY (customerId))`);

    // Add records to the newly created table.
    result = check jdbcClient -> execute(`INSERT INTO Customers (firstName,
            lastName, registrationID,creditLimit,country) VALUES ('Peter',
            'Stuart', 1, 5000.75, 'USA')`);
}

// Cleans up the database after running the example.
function afterRunningExample(jdbc:Client jdbcClient) returns sql:Error? {
    // Clean the database.
    sql:ExecutionResult result =
            check jdbcClient -> execute(`DROP TABLE Customers`);
    // Close the JDBC client.
    check jdbcClient.close();
}

public function main() returns error? {
    // Initialize the JDBC client.
    jdbc:Client jdbcClient = check new ("jdbc:h2:file:./target/bbes/java_jdbc",
        "rootUser", "rootPass");
    // Run the prerequisite setup for the example.
    check beforeRunningExample(jdbcClient);

    // Simulate Failure Rollback.
    check simulateBatchExecuteFailure(jdbcClient);

    // Check the data.
    check tableInspectAfterBatchExecute(jdbcClient);

    // Perform cleanup after the example.
    check afterRunningExample(jdbcClient);
}
