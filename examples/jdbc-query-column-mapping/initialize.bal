import ballerina/sql;
import ballerinax/java.jdbc;

// Initializes the database as a prerequisite to the example.
function initialize() returns sql:Error? {
    jdbc:Client jdbcClient = check new ("jdbc:h2:file:./target/bbes/java_jdbc", "rootUser", "rootPass");

    // Creates a table in the database.
    _ = check jdbcClient->execute(`CREATE TABLE Customers (customer_id INTEGER NOT NULL AUTO_INCREMENT,
                                    first_name VARCHAR(300), last_name  VARCHAR(300), PRIMARY KEY (customer_id))`);

    // Adds the records to the newly-created table.
    _ = check jdbcClient->execute(`INSERT INTO Customers (first_name, last_name) VALUES ('Peter','Stuart')`);
    _ = check jdbcClient->execute(`INSERT INTO Customers (first_name, last_name) VALUES ('Dan', 'Brown')`);

    check jdbcClient.close();
}
