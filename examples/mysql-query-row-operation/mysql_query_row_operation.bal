import ballerina/io;
import ballerinax/mysql;

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

    // Initializes the MySQL client. The `mysqlClient` can be reused to access the database throughout the application execution.
    mysql:Client mysqlClient = check new (user = "root", password = "Test@123", database = "CUSTOMER");

    int customerId = 1;
    // Query table to return one result.
    Customer customer = check mysqlClient->queryRow(`SELECT * FROM Customers
                                                     WHERE customerId > ${customerId};`);

    io:println(`Customer (customerId = 1) : ${customer}`);

    // Closes the MySQL client.
    check mysqlClient.close();

    // Performs the cleanup after the example.
    check cleanup();
}
