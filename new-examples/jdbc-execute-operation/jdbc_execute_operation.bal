import ballerina/io;
import ballerinax/java.jdbc;
import ballerina/sql;

function updateRecord(jdbc:Client jdbcClient) returns sql:Error? {
    float newCreditLimit = 15000.5;

    // Create a parameterized query for record update.
    sql:ParameterizedQuery updateQuery = 
            `UPDATE Customers SET creditLimit = ${newCreditLimit} 
            where customerId = 1`;

    sql:ExecutionResult result = check jdbcClient -> execute(updateQuery);
    io:println("Updated Row count: ", result?.affectedRowCount);
}

function deleteRecord(jdbc:Client jdbcClient) returns sql:Error? {
    string firstName = "Dan";

    // Create a parameterized query for record delete.
    sql:ParameterizedQuery deleteQuery =
            `DELETE FROM Customers WHERE firstName = ${firstName}`;
    sql:ExecutionResult result = check jdbcClient -> execute(deleteQuery);
    io:println("Deleted Row count: ", result.affectedRowCount);
}

// Initializes the database as the prerequisite to the example.
function beforeRunningExample(jdbc:Client jdbcClient) returns sql:Error? {
    //Create a table in the database.
    sql:ExecutionResult result =
        check jdbcClient -> execute(`CREATE TABLE Customers(customerId INTEGER
            NOT NULL IDENTITY, firstName  VARCHAR(300), lastName  VARCHAR(300),
            registrationID INTEGER, creditLimit DOUBLE, country  VARCHAR(300),
            PRIMARY KEY (customerId))`);

    // Insert data into the table. The result will have `affectedRowCount`
    // and `lastInsertedId` with the auto-generated ID of the last row.
    result = check jdbcClient -> execute(`INSERT INTO Customers (firstName,
            lastName, registrationID,creditLimit,country) VALUES ('Peter',
            'Stuart', 1, 5000.75, 'USA')`);
    result = check jdbcClient -> execute(`INSERT INTO Customers (firstName,
            lastName, registrationID,creditLimit,country) VALUES ('Dan', 'Brown',
            2, 10000, 'UK')`);

    io:println("Rows affected: ", result.affectedRowCount);
    io:println("Generated Customer ID: ", result.lastInsertId);        
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

    // Update a record.
    check updateRecord(jdbcClient);

    // Delete a record.
    check deleteRecord(jdbcClient);

    // Perform cleanup after the example.
    check afterRunningExample(jdbcClient);
}
