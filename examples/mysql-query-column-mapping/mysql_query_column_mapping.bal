import ballerina/io;
import ballerinax/mysql;
import ballerina/sql;
import ballerinax/mysql.driver as _;

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
    // Runs the prerequisite setup for the example.
    check initialize();

    // Initializes the MySQL client. The `mysqlClient` can be reused to access the database throughout the application execution.
    mysql:Client mysqlClient = check new (user = "root", password = "Test@123", database = "CUSTOMER");

    // Query table with a condition.
    stream<Customer, error?> resultStream = mysqlClient->query(`SELECT * FROM Customers;`);

    // Iterates the result stream.
    check from Customer customer in resultStream
        do {
            io:println(`Customer details: ${customer}`);
        };

    // Closes the stream to release the resources.
    check resultStream.close();

    // Closes the MySQL client.
    check mysqlClient.close();

    // Performs the cleanup after the example.
    check cleanup();
}
