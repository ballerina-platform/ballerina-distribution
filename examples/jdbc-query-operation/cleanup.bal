import ballerina/sql;
import ballerinax/java.jdbc;

// Cleans up the database after running the example.
function cleanup() returns sql:Error? {
    jdbc:Client jdbcClient = check new ("jdbc:h2:file:./target/bbes/java_jdbc",
        "rootUser", "rootPass");

    // Cleans the database.
    _ = check jdbcClient->execute(`DROP TABLE Customers`);

    check jdbcClient.close();
}
