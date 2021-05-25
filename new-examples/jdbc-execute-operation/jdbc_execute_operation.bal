import ballerina/io;
import ballerinax/java.jdbc;
import ballerina/sql;

public function main() returns error? {
    // Initialize the JDBC client.
    jdbc:Client jdbcClient = check new ("jdbc:h2:file:./target/bbes/java_jdbc",
        "rootUser", "rootPass");
    // Run the prerequisite setup for the example.
    check beforeExample(jdbcClient);

    float newCreditLimit = 15000.5;

    // Create a parameterized query for record update.
    sql:ParameterizedQuery updateQuery = 
            `UPDATE Customers SET creditLimit = ${newCreditLimit} 
            where customerId = 1`;

    sql:ExecutionResult result = check jdbcClient -> execute(updateQuery);
    io:println("Updated Row count: ", result?.affectedRowCount);

    string firstName = "Dan";

    // Create a parameterized query for record delete.
    sql:ParameterizedQuery deleteQuery =
            `DELETE FROM Customers WHERE firstName = ${firstName}`;
    
    result = check jdbcClient -> execute(deleteQuery);
    io:println("Deleted Row count: ", result.affectedRowCount);

    // Perform cleanup after the example.
    check afterExample(jdbcClient);
}

// Initializes the database as the prerequisite to the example.
function beforeExample(jdbc:Client jdbcClient) returns sql:Error? {
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
function afterExample(jdbc:Client jdbcClient) returns sql:Error? {
    // Clean the database.
    sql:ExecutionResult result =
            check jdbcClient -> execute(`DROP TABLE Customers`);
    // Close the JDBC client.
    check jdbcClient.close();
}
