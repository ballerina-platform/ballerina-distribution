import ballerina/io;
import ballerina/mysql;
import ballerina/sql;

// The username and password of the MySQL database. This is used in the below
// examples when initializing the MySQL connector. You need to change these
// based on your setup if you try locally.
string dbUser = "root";
string dbPassword = "Test@123";
string dbName = "MYSQL_BBE_EXEC";

function initializeDatabase() returns sql:Error? {
    // Initialize the client without any database to create the database.
    mysql:Client mysqlClient = check new (user = dbUser, password = dbPassword);
    // Create the database if it does not exist. If any error occurred,
    // the error will be returned.
    sql:ExecutionResult? result =
        check mysqlClient->execute("CREATE DATABASE IF NOT EXISTS " + dbName);
    io:println("Database created. ");
    // Close the MySQL client.
    check mysqlClient.close();
}

function initializeTable(mysql:Client mysqlClient)
returns sql:Error? {
    // Execute dropping the table. The `sql:ExecutionResult` is returned upon
    // successful execution. An error will be returned in case of a failure.
    sql:ExecutionResult? result =
        check mysqlClient->execute("DROP TABLE IF EXISTS Customers");
    if (result is sql:ExecutionResult) {
        io:println("Drop table executed: ", result);
    }

    // Similarly, to drop a table, the `create` table query is executed.
    // Here, the `customerId` is an auto-generated column.
    result = check mysqlClient->execute("CREATE TABLE IF NOT EXISTS Customers" +
        "(customerId INTEGER NOT NULL AUTO_INCREMENT, firstName VARCHAR(300), " +
        "lastName VARCHAR(300), registrationID INTEGER, creditLimit DOUBLE, " +
        "country VARCHAR(300), PRIMARY KEY (customerId))");
    if (result is sql:ExecutionResult) {
        io:println("Create table executed: ", result);
    }

}

function insertRecords(mysql:Client mysqlClient) returns int[] {

    // Records to be inserted.
    var insertRecords = [
        {firstName: "Peter", lastName: "Stuart", registrationID: 1,
                                    creditLimit: 5000.75, country: "USA"},
        {firstName: "Stephanie", lastName: "Mike", registrationID: 2,
                                    creditLimit: 8000.00, country: "USA"},
        {firstName: "Bill", lastName: "John", registrationID: 3,
                                    creditLimit: 3000.25, country: "USA"}
    ];

    sql:ParameterizedQuery[] insertQueries =
            from var data in insertRecords
                select  `INSERT INTO Customers
                    (firstName, lastName, registrationID, creditLimit, country)
                    VALUES (${data.firstName}, ${data.lastName},
                    ${data.registrationID}, ${data.creditLimit}, ${data.country})`;
    
    // Insert the records with the auto-generated ID.
    sql:ExecutionResult[]|sql:Error? result =
        mysqlClient->batchExecute(insertQueries);

    int[] generatedIds = [];
    if (result is sql:ExecutionResult[]) {
        foreach var summary in result {
            generatedIds.push(<int> summary.lastInsertId);
        }
        io:println("\nGenerated IDs are: ", generatedIds);
    } else if (result is sql:Error) {
        io:println("Error occured: ", result);
    } else {
        io:println("Empty result");
    }
    return generatedIds;
}

function updateRecords(mysql:Client mysqlClient, int[] generatedIds) {

    // The update queries.
    sql:ParameterizedQuery[] updateQueries =
            from var id in generatedIds
                select `Update Customers
                        set creditLimit = creditLimit + 1000.0
                        where customerId =${id}`;

    // Update the record with the auto-generated ID.
    sql:ExecutionResult[]|sql:Error? result =
        mysqlClient->batchExecute(updateQueries);
    if (result is sql:ExecutionResult[]) {
        io:println("\nUpdated Rows summary: ", result);
    } else if (result is sql:Error) {
        io:println("Error occurred: ", result);
    } else {
        io:println("Empty result");
    }

}

public function main() {
    // Initialize the database.
    sql:Error? err = initializeDatabase();
    if (err is ()) {
        // Initialize the MySQL client to be used for the rest of the DDL
        // and DML operations.
        mysql:Client|sql:Error mysqlClient = new (user = dbUser,
            password = dbPassword, database = dbName);
        if (mysqlClient is mysql:Client) {
            // Initialize a table and insert sample data.
            sql:Error? initResult = initializeTable(mysqlClient);
            if (initResult is ()) {
                // Insert a batch of records.
                int[] generatedIds = insertRecords(mysqlClient);
                // Update records.
                updateRecords(mysqlClient, generatedIds);

                // Check the data.
                checkData(mysqlClient);
                io:println("\nSample executed successfully!");
            } else {
                io:println("Customer table initialization failed: ", initResult);
            }
            // Close the MySQL client.
            sql:Error? e = mysqlClient.close();
        } else {
            io:println("Table initialization failed!!", mysqlClient);
        }
    } else {
        io:println("Database initialization failed!!", err);
    }
}

function checkData(mysql:Client mysqlClient) {
     stream<record{}, error> resultStream =
        mysqlClient->query("Select * from Customers");

     io:println("\nData in Customers table:");
     error? e = resultStream.forEach(function(record {} result) {
                 io:println(result.toString());
     });
     if (e is error) {
        io:println("Select data from Customers table failed!");
        io:println(e);
     }
}
