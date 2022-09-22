import ballerina/io;
import ballerinax/java.jdbc;

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

    // Initializes the JDBC client. The `jdbcClient` can be reused to access the database throughout the application execution.
    jdbc:Client jdbcClient = check new ("jdbc:h2:file:./target/bbes/java_jdbc", "rootUser", "rootPass");

    int customerId = 1;
    // Query table to return one result.
    Customer customer =
            check jdbcClient->queryRow(`SELECT * FROM Customers WHERE customerId > ${customerId};`);

    io:println(`Customer (customerId = 1) : ${customer}`);

    // Closes the JDBC client.
    check jdbcClient.close();

    // Performs the cleanup after the example.
    check cleanup();
}
