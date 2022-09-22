import ballerina/io;
import ballerinax/java.jdbc;
import ballerina/sql;

public function main() returns error? {

    // Runs the prerequisite setup for the example.
    check initialize();

    // Initializes the JDBC client. The `jdbcClient` can be reused to access the database throughout the application execution.
    jdbc:Client jdbcClient = check new ("jdbc:h2:file:./target/bbes/java_jdbc", "rootUser", "rootPass");

    float newCreditLimit = 15000.5;

    // Execute the query.
    sql:ExecutionResult result = check jdbcClient->execute(`UPDATE Customers
                                        SET creditLimit = ${newCreditLimit} WHERE customerId = 1`);

    // Process returned metadata.
    io:println(`Updated Row count: ${result?.affectedRowCount}`);

    // Closes the JDBC client.
    check jdbcClient.close();

    // Performs the cleanup after the example.
    check cleanup();
}
