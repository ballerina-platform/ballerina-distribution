import ballerina/sql;
import ballerinax/mysql;
import ballerina/io;

// The username and password of the MySQL database and database
// name which is used to drop the tables. You can change these
// based on your setup.
string dbUser = "root";
string dbPassword = "Ashakalai123@";
string dbName = "MYSQL_BBE";
string[] tableNames = ["Student"];

// Initializes the MySQL client to be used to delete
// the created table.
mysql:Client sqlClient = check new (user = dbUser,
    password = dbPassword, database = dbName);

public function main() returns error? {

    io:println("\nStarts to drop the tables!");
    // Drops tables.
    foreach var tableName in tableNames {
        sql:ExecutionResult result =
            check sqlClient -> execute("DROP TABLE " + tableName);
    }
    io:println("\nDrop the tables successfully done!");

    // Close the JDBC client.
    check sqlClient.close();

}
