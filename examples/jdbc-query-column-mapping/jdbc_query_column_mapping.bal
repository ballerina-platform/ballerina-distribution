import ballerina/io;
import ballerinax/java.jdbc;
import ballerina/sql;

// Defines a record to load the query result.
type Customer record {|
    @sql:Column {name: "customer_id"}
    int customerId;
    @sql:Column {name: "last_name"}
    string lastName;
    @sql:Column {name: "first_name"}
    string firstName;
|};

public function main() returns error? {
    // Initializes the JDBC client. The `jdbcClient` can be reused to access the database throughout the application execution.
    jdbc:Client jdbcClient = check new ("jdbc:h2:file:./target/bbes/java_jdbc",
        "rootUser", "rootPass");
    // Runs the prerequisite setup for the example.
    check initialize(jdbcClient);

    // Query table with a condition.
    stream<Customer, error?> resultStream =
            jdbcClient->query(`SELECT * FROM Customers;`);

    // Iterates the result stream.
    check from Customer customer in resultStream
        do {
            io:println(`Customer details: ${customer}`);
        };

    // Closes the stream to release the resources.
    check resultStream.close();

    // Performs the cleanup after the example.
    check cleanup(jdbcClient);

    // Closes the JDBC client.
    check jdbcClient.close();
}

// Initializes the database as a prerequisite to the example.
function initialize(jdbc:Client jdbcClient) returns sql:Error? {
    // Creates a table in the database.
    _ = check jdbcClient->execute(`CREATE TABLE Customers
            (customer_id INTEGER NOT NULL AUTO_INCREMENT, first_name
            VARCHAR(300), last_name  VARCHAR(300),
            PRIMARY KEY (customer_id))`);

    // Adds the records to the newly-created table.
    _ = check jdbcClient->execute(`INSERT INTO Customers
            (first_name, last_name) VALUES ('Peter','Stuart')`);
    _ = check jdbcClient->execute(`INSERT INTO Customers
            (first_name, last_name) VALUES ('Dan', 'Brown')`);
}

// Cleans up the database after running the example.
function cleanup(jdbc:Client jdbcClient) returns sql:Error? {
    // Cleans the table.
    _ = check jdbcClient->execute(`DROP TABLE Customers`);
}
