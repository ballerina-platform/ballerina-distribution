import ballerina/io;
import ballerinax/java.jdbc;
import ballerina/sql;

public function main() returns error? {
    // Initializes the JDBC client.
    jdbc:Client jdbcClient = check new ("jdbc:h2:file:./target/bbes/java_jdbc",
        "rootUser", "rootPass");
    // Runs the prerequisite setup for the example.
    check beforeExample(jdbcClient);

    // Records with the duplicate `registrationID` entry. Here it is registrationID = 1.
    var insertRecords = [
        {firstName: "Linda", lastName: "Jones", registrationID: 2,
                                    creditLimit: 10000.75, country: "USA"},
        {firstName: "Peter", lastName: "Stuart", registrationID: 1,
                                    creditLimit: 5000.75, country: "USA"},
        {firstName: "Camellia", lastName: "Potter", registrationID: 4,
                                    creditLimit: 2000.25, country: "USA"}
    ];

    // Creates a batch parameterized query.
    sql:ParameterizedQuery[] insertQueries =
        from var data in insertRecords
            select  `INSERT INTO Customers
                (firstName, lastName, registrationID, creditLimit, country)
                VALUES (${data.firstName}, ${data.lastName},
                ${data.registrationID}, ${data.creditLimit}, ${data.country})`;

    // The transaction block can be used to roll back if any error occurred.
    transaction {
        var result = jdbcClient->batchExecute(insertQueries);
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

    // Checks the data after the batch execution.
    stream<record{}, error> resultStream =
        jdbcClient->query(`SELECT * FROM Customers`);

    io:println("Data in Customers table:");
    error? e = resultStream.forEach(function(record {} result) {
                 io:println(result.toString());
    });

    // Performs the cleanup after the example.
    check afterExample(jdbcClient);
}

// Initializes the database as a prerequisite to the example.
function beforeExample(jdbc:Client jdbcClient) returns sql:Error? {
    // Creates a table in the database.
    sql:ExecutionResult result =
        check jdbcClient->execute(`CREATE TABLE Customers(customerId INTEGER
            NOT NULL IDENTITY, firstName  VARCHAR(300), lastName  VARCHAR(300),
            registrationID INTEGER UNIQUE, creditLimit DOUBLE,
            country VARCHAR(300), PRIMARY KEY (customerId))`);

    // Adds records to the newly-created table.
    result = check jdbcClient->execute(`INSERT INTO Customers (firstName,
            lastName, registrationID,creditLimit,country) VALUES ('Peter',
            'Stuart', 1, 5000.75, 'USA')`);
}

// Cleans up the database after running the example.
function afterExample(jdbc:Client jdbcClient) returns sql:Error? {
    // Cleans the database.
    sql:ExecutionResult result =
            check jdbcClient->execute(`DROP TABLE Customers`);
    // Closes the JDBC client.
    check jdbcClient.close();
}
