import ballerina/io;
import ballerinax/java.jdbc;
import ballerina/sql;

public function main() returns error? {
    // Initialize the JDBC client.
    jdbc:Client jdbcClient = check new ("jdbc:h2:file:./target/bbes/java_jdbc",
        "rootUser", "rootPass");
    // Run the prerequisite setup for the example.
    check beforeExample(jdbcClient);

    // Records to be inserted.
    var insertRecords = [
        {firstName: "Peter", lastName: "Stuart", registrationID: 1,
                                    creditLimit: 5000.75, country: "USA"},
        {firstName: "Stephanie", lastName: "Mike", registrationID: 2,
                                    creditLimit: 8000.00, country: "USA"},
        {firstName: "Bill", lastName: "John", registrationID: 3,
                                    creditLimit: 3000.25, country: "USA"}
    ];

    // Create a batch Parameterized Query.
    sql:ParameterizedQuery[] insertQueries =
        from var data in insertRecords
            select  `INSERT INTO Customers
                (firstName, lastName, registrationID, creditLimit, country)
                VALUES (${data.firstName}, ${data.lastName},
                ${data.registrationID}, ${data.creditLimit}, ${data.country})`;
    
    // Insert the records with the auto-generated ID.
    sql:ExecutionResult[] result = check jdbcClient -> batchExecute(insertQueries);

    int[] generatedIds = [];
    foreach var summary in result {
        generatedIds.push(<int> summary.lastInsertId);
    }
    io:println("\nInsert success, generated IDs are: ", generatedIds, "\n");

    // Check the data after batch execute.
    stream<record{}, error> resultStream =
        jdbcClient -> query("SELECT * FROM Customers");

    io:println("Data in Customers table:");
    error? e = resultStream.forEach(function(record {} result) {
                 io:println(result.toString());
    });

    // Perform cleanup after the example.
    check afterExample(jdbcClient);
}

// Initializes the database as the prerequisite to the example.
function beforeExample(jdbc:Client jdbcClient) returns sql:Error? {
    // Create a table in the database.
    sql:ExecutionResult result =
        check jdbcClient -> execute(`CREATE TABLE Customers(customerId INTEGER
            NOT NULL IDENTITY, firstName  VARCHAR(300), lastName  VARCHAR(300),
            registrationID INTEGER, creditLimit DOUBLE, country  VARCHAR(300),
            PRIMARY KEY (customerId))`);      
}

// Cleans up the database after running the example.
function afterExample(jdbc:Client jdbcClient) returns sql:Error? {
    // Clean the database.
    sql:ExecutionResult result =
            check jdbcClient -> execute(`DROP TABLE Customers`);
    // Close the JDBC client.
    check jdbcClient.close();
}
