import ballerina/log;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

public function main() returns error? {

    // Initializes the MySQL client. The `mysqlClient` can be reused to access the database throughout the application execution.
    mysql:Client mysqlClient = check new (host = "localhost", port = 3306, user = "root",
                                          password = "Test@123", database = "CUSTOMER");

    // The transaction block can be used to roll back if any error occurred.
    transaction {
        _ = check mysqlClient->execute(`INSERT INTO Customers (firstName, lastName, registrationID, creditLimit,
                                        country) VALUES ('Linda', 'Jones', 4, 10000.75, 'USA')`);

        _ = check mysqlClient->execute(`INSERT INTO Customers (firstName, lastName, registrationID, creditLimit,
                                        country) VALUES ('Peter', 'Stuart', 4, 5000.75, 'USA')`);

        check commit;
    } on fail error e {
        log:printError(e.message());
        log:printInfo("One of the queries failed. Rollback transaction.");
    }

    // Closes the MySQL client.
    check mysqlClient.close();

}
