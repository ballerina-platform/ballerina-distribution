import ballerina/io;
import ballerinax/mysql;
import ballerina/sql;

// Defines a record to load the query result schema as shown below in the
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
    // Runs the prerequisite setup for the example.
    check beforeExample();

    // Initializes the MySQL client.
    mysql:Client mysqlClient = check new (user = "root",
            password = "Test@123", database = "MYSQL_BBE");

    // Select the rows in the database table via the query remote operation.
    // The result is returned as a stream and the elements of the stream can
    // be either a record or an error. The name and type of the attributes 
    // within the record from the `resultStream` will be automatically 
    // identified based on the column name and type of the query result.
    stream<record{}, error> resultStream =
             mysqlClient -> query(`SELECT * FROM Customers`);

    // If there is any error during the execution of the SQL query or
    // iteration of the result stream, the result stream will terminate and
    // return the error.
    error? e = resultStream.forEach(function(record {} result) {
        io:println("Full Customer details: ", result);
    });

    // The result of the count operation is provided as a record stream.
    stream<record{}, error> resultStream2 =
            mysqlClient -> query(`SELECT COUNT(*) AS total FROM Customers`);

    // Since the above count query will return only a single row,
    // the `next()` operation is sufficient to retrieve the data.
    record {|record {} value;|}|error? result = resultStream2.next();
    // Checks the result and retrieves the value for the total.
    if result is record {|record {} value;|} {
        io:println("Total rows in customer table : ", result.value["total"]);
    } 

    // In general cases, the stream will be closed automatically
    // when the stream is fully consumed or any error is encountered.
    // However, in case if the stream is not fully consumed, the stream
    // should be closed specifically.
    error? er = resultStream.close();

    // The result is returned as a `Customer` record stream and the elements
    // of the stream can be either a `Customer` record or an error.
    stream<record{}, error> resultStream3 =
        mysqlClient->query(`SELECT * FROM Customers`, Customer);

    // Casts the generic record type to the `Customer` stream type.
    stream<Customer, sql:Error> customerStream =
        <stream<Customer, sql:Error>>resultStream3;

    // Iterates the customer stream.
    error? e2 = customerStream.forEach(function(Customer customer) {
        io:println("Full Customer details: ", customer);
    });

    // Performs the cleanup after the example.
    check afterExample(mysqlClient);
}

// Initializes the database as a prerequisite to the example.
function beforeExample() returns sql:Error? {
    mysql:Client mysqlClient = check new (user = "root", password = "Test@123");

    // Creates a Database.
    sql:ExecutionResult result =
        check mysqlClient -> execute(`CREATE DATABASE MYSQL_BBE`);

    // Creates a table in the database.
    result = check mysqlClient -> execute(`CREATE TABLE MYSQL_BBE.Customers(customerId 
            INTEGER NOT NULL AUTO_INCREMENT, firstName  VARCHAR(300), lastName  VARCHAR(300),
            registrationID INTEGER, creditLimit DOUBLE, country  VARCHAR(300),
            PRIMARY KEY (customerId))`);

    // Adds records to the newly created table.
    result = check mysqlClient -> execute(`INSERT INTO MYSQL_BBE.Customers(firstName,
            lastName, registrationID,creditLimit,country) VALUES ('Peter',
            'Stuart', 1, 5000.75, 'USA')`);
    result = check mysqlClient -> execute(`INSERT INTO MYSQL_BBE.Customers(firstName,
            lastName, registrationID,creditLimit,country) VALUES ('Dan', 'Brown',
            2, 10000, 'UK')`);

    check mysqlClient.close();        
}

// Cleans up the database after running the example.
function afterExample(mysql:Client mysqlClient) returns sql:Error? {
    // Cleans the database.
    sql:ExecutionResult result =
            check mysqlClient -> execute(`DROP DATABASE MYSQL_BBE`);
    // Closes the MySQL client.
    check mysqlClient.close();
}
