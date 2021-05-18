import ballerina/sql;
import ballerinax/mysql;
import ballerina/io;

// The username and password of the MySQL database and database
// name which is used to drop the tables. You can change these
// based on your setup.
string dbUser = "DB_USER_NAME";
string dbPassword = "DB_PASSWORD";
string dbName = "DB_NAME";
string[] tableNames = ["Student"];

// Initializes the MySQL client to be used to delete
// the created table.
mysql:Client sqlClient = check new (user = dbUser,
    password = dbPassword, database = dbName);

public function main() returns error? {

    io:println("\nStarts to clean bbe tables...");
    // Drops tables.
    foreach var tableName in tableNames {
        sql:ExecutionResult result =
            check sqlClient -> execute("DROP TABLE " + tableName);
    }
    io:println("\nDropped table successfully!");

    // Close the JDBC client.
    check sqlClient.close();

}
