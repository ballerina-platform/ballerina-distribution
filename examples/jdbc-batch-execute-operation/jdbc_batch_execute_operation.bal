import ballerina/io;
import ballerinax/java.jdbc;
import ballerina/sql;

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

    // Initializes the JDBC client. The `jdbcClient` can be reused to access the database throughout the application execution.
    jdbc:Client jdbcClient = check new ("jdbc:h2:file:./target/bbes/java_jdbc", "rootUser", "rootPass");

    // The records to be inserted.
    Customer[] customers = [
        {firstName: "Peter", lastName: "Stuart", registrationID: 1, creditLimit: 5000.75, country: "USA"},
        {firstName: "Stephanie", lastName: "Mike", registrationID: 2, creditLimit: 8000.00, country: "USA"},
        {firstName: "Bill", lastName: "John", registrationID: 3, creditLimit: 3000.25, country: "USA"}
    ];

    // Creates a batch-parameterized query.
    sql:ParameterizedQuery[] insertQueries =
        from var data in customers
        select `INSERT INTO Customers (firstName, lastName, registrationID, creditLimit, country)
                VALUES (${data.firstName}, ${data.lastName}, ${data.registrationID},
                ${data.creditLimit}, ${data.country})`;

    // Inserts the records with the auto-generated ID.
    sql:ExecutionResult[] result = check jdbcClient->batchExecute(insertQueries);

    int[] generatedIds = [];
    foreach sql:ExecutionResult summary in result {
        generatedIds.push(<int>summary.lastInsertId);
    }
    io:println(`Insert success, generated IDs are: ${generatedIds}`);

    // Closes the JDBC client.
    check jdbcClient.close();

    // Performs the cleanup after the example.
    check cleanup();
}
