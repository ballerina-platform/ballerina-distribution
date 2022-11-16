import ballerina/sql;
import ballerinax/mysql;

// Cleans up the database after running the example.
function cleanup() returns sql:Error? {
    mysql:Client mysqlClient = check new (user = "root", password = "Test@123");

    // Cleans the database.
    _ = check mysqlClient->execute(`DROP DATABASE CUSTOMER`);

    // Closes the MySQL client.
    check mysqlClient.close();
}
