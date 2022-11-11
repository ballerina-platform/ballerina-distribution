import ballerina/log;
import ballerinax/java.jdbc;

public function main() returns error? {

    // Runs the prerequisite setup for the example.
    check initialize();

    // Initializes the JDBC client. The `jdbcClient` can be reused to access the database throughout the application execution.
    jdbc:Client jdbcClient = check new ("jdbc:h2:file:./target/bbes/java_jdbc", "rootUser", "rootPass");

    // The transaction block can be used to roll back if any error occurred.
    transaction {
        _ = check jdbcClient->execute(`INSERT INTO Customers (firstName, lastName, registrationID,
                                        creditLimit, country) VALUES ('Linda', 'Jones', 4, 10000.75, 'USA')`);

        _ = check jdbcClient->execute(`INSERT INTO Customers (firstName, lastName, registrationID, creditLimit, country)
                                        VALUES ('Peter', 'Stuart', 4, 5000.75, 'USA')`);

        check commit;
    } on fail error e {
        log:printError(e.message());
        log:printInfo("One of the queries failed. Rollback transaction.");
    }

    // Closes the JDBC client.
    check jdbcClient.close();

    // Performs the cleanup after the example.
    check cleanup();
}
