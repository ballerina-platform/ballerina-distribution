import ballerina/io;
import ballerinax/mysql;
import ballerina/sql;
import ballerinax/mysql.driver as _;

public function main() returns error? {

    // Initializes the MySQL client. The `mysqlClient` can be reused to access the database throughout the application execution.
    mysql:Client mysqlClient = check new (host = "localhost", port = 3306, user = "root",
                                          password = "Test@123", database = "CUSTOMER");

    float newCreditLimit = 15000.5;

    // Execute the query.
    sql:ExecutionResult result = check mysqlClient->execute(`UPDATE Customers
                                        SET creditLimit = ${newCreditLimit} WHERE customerId = 1`);

    // Process returned metadata.
    io:println(`Updated Row count: ${result?.affectedRowCount}`);

    // Closes the MySQL client.
    check mysqlClient.close();

}
