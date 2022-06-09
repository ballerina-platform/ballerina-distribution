import ballerina/io;
import ballerinax/java.jdbc;
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
    // Initializes the JDBC client. The `jdbcClient` can be reused to access database throughout the application execution.
    jdbc:Client jdbcClient = check new ("jdbc:h2:file:./target/bbes/java_jdbc",
        "rootUser", "rootPass");
    // Runs the prerequisite setup for the example.
    check initialization(jdbcClient);

    int customerId = 1;
    // Query table to return one result.
    Customer customer =
            check jdbcClient->queryRow(`SELECT * FROM Customers
                                    WHERE customerId > ${customerId};`);

    io:println(`Customer (customerId = 1) : ${customer}`);

    // Performs the cleanup after the example.
    check cleanup(jdbcClient);

    // Closes the JDBC client.
    check jdbcClient.close();
}

// Initializes the database as a prerequisite to the example.
function initialization(jdbc:Client jdbcClient) returns sql:Error? {
    // Creates a table in the database.
    _ = check jdbcClient->execute(`CREATE TABLE Customers
            (customerId INTEGER NOT NULL AUTO_INCREMENT, firstName
            VARCHAR(300), lastName  VARCHAR(300), registrationID INTEGER,
            creditLimit DOUBLE, country  VARCHAR(300),
            PRIMARY KEY (customerId))`);

    // Adds the records to the newly-created table.
    _ = check jdbcClient->execute(`INSERT INTO Customers
            (firstName, lastName, registrationID,creditLimit,country) VALUES
            ('Peter','Stuart', 1, 5000.75, 'USA')`);
    _ = check jdbcClient->execute(`INSERT INTO Customers
            (firstName, lastName, registrationID,creditLimit,country) VALUES
            ('Dan', 'Brown', 2, 10000, 'UK')`);
}

// Cleans up the database after running the example.
function cleanup(jdbc:Client jdbcClient) returns sql:Error? {
    // Cleans the database.
    _ = check jdbcClient->execute(`DROP TABLE Customers`);
}
