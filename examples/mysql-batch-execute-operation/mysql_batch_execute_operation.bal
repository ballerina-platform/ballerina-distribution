import ballerina/io;
import ballerinax/mysql;
import ballerina/sql;
import ballerinax/mysql.driver as _;

// Defines a record.
type Customer record {|
    string firstName;
    string lastName;
    int registrationID;
    float creditLimit;
    string country;
|};

public function main() returns error? {
    // Runs the prerequisite setup for the example.
    check initialize();

    // Initializes the MySQL client. The `mysqlClient` can be reused to access the database throughout the application execution.
    mysql:Client mysqlClient = check new (user = "root", password = "Test@123", database = "CUSTOMER");

    // The records to be inserted.
    Customer[] customers = [
        {firstName: "Peter", lastName: "Stuart", registrationID: 1, creditLimit: 5000.75, country: "USA"},
        {firstName: "Stephanie", lastName: "Mike", registrationID: 2, creditLimit: 8000.00, country: "USA"},
        {firstName: "Bill", lastName: "John", registrationID: 3, creditLimit: 3000.25, country: "USA"}
    ];

    // Creates a batch-parameterized query.
    sql:ParameterizedQuery[] insertQueries =
        from Customer customer in customers
        select `INSERT INTO Customers (firstName, lastName, registrationID, creditLimit, country)
                VALUES (${customer.firstName}, ${customer.lastName}, ${customer.registrationID},
                ${customer.creditLimit}, ${customer.country})`;

    // Inserts the records with the auto-generated ID.
    sql:ExecutionResult[] result = check mysqlClient->batchExecute(insertQueries);

    int[] generatedIds = [];
    foreach sql:ExecutionResult summary in result {
        generatedIds.push(<int>summary.lastInsertId);
    }
    io:println(`Insert success, generated IDs are: ${generatedIds}`);

    // Closes the MySQL client.
    check mysqlClient.close();

    // Performs the cleanup after the example.
    check cleanup();
}
