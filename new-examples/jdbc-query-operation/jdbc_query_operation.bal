import ballerina/io;
import ballerinax/java.jdbc;
import ballerina/sql;

// Define a record to load the query result schema as shown below in the
// 'getDataWithTypedQuery' function. In this example, all columns of the 
// customer table will be loaded. Therefore, the `Customer` record will be 
// created with all the columns. The column name of the result and the 
// defined field name of the record will be matched case insensitively.
type Customer record {|
    int customerId;
    string lastName;
    string firstName;
    int registrationId;
    float creditLimit;
    string country;
|};

public function main() returns error? {
    // Initialize the JDBC client.
    jdbc:Client jdbcClient = check new ("jdbc:h2:file:./target/bbes/java_jdbc",
        "rootUser", "rootPass");
    // Run the prerequisite setup for the example.
    check beforeExample(jdbcClient);

    // Select the rows in the database table via the query remote operation.
    // The result is returned as a stream and the elements of the stream can
    // be either a record or an error. The name and type of the attributes 
    // within the record from the `resultStream` will be automatically 
    // identified based on the column name and type of the query result.
    stream<record{}, error> resultStream =
             jdbcClient -> query(`SELECT * FROM Customers`);

    // If there is any error during the execution of the SQL query or
    // iteration of the result stream, the result stream will terminate and
    // return the error.
    error? e = resultStream.forEach(function(record {} result) {
        io:println("Full Customer details: ", result);
    });

    // The result of the count operation is provided as a record stream.
    stream<record{}, error> resultStream2 =
            jdbcClient -> query(`SELECT COUNT(*) AS total FROM Customers`);

    // Since the above count query will return only a single row,
    // the `next()` operation is sufficient to retrieve the data.
    record {|record {} value;|}|error? result = resultStream2.next();
    // Check the result and retrieve the value for total.
    if result is record {|record {} value;|} {
        io:println("Total rows in customer table : ", result.value["TOTAL"]);
    } 

    // In general cases, the stream will be closed automatically
    // when the stream is fully consumed or any error is encountered.
    // However, in case if the stream is not fully consumed, the stream
    // should be closed specifically.
    error? er = resultStream.close();

    // The result is returned as a Customer record stream and the elements
    // of the stream can be either a Customer record or an error.
    stream<record{}, error> resultStream3 =
        jdbcClient->query(`SELECT * FROM Customers`, Customer);

    // Cast the generic record type to the Customer stream type.
    stream<Customer, sql:Error> customerStream =
        <stream<Customer, sql:Error>>resultStream3;

    // Iterate the customer stream.
    e = customerStream.forEach(function(Customer customer) {
        io:println("Full Customer details: ", customer);
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

    // Add records to the newly created table.
    result = check jdbcClient -> execute(`INSERT INTO Customers (firstName,
            lastName, registrationID,creditLimit,country) VALUES ('Peter',
            'Stuart', 1, 5000.75, 'USA')`);
    result = check jdbcClient -> execute(`INSERT INTO Customers (firstName,
            lastName, registrationID,creditLimit,country) VALUES ('Dan', 'Brown',
            2, 10000, 'UK')`);
}

// Cleans up the database after running the example.
function afterExample(jdbc:Client jdbcClient) returns sql:Error? {
    // Clean the database.
    sql:ExecutionResult result =
            check jdbcClient -> execute(`DROP TABLE Customers`);
    // Close the JDBC client.
    check jdbcClient.close();
}
