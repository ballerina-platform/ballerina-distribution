import ballerina/io;
import ballerinax/java.jdbc;
import ballerina/lang.'transaction as transactions;

string xaDatasourceName = "org.h2.jdbcx.JdbcDataSource";

public function main() returns error? {
    // The JDBC Client for the first H2 database.
    jdbc:Client dbClient1 = check new (url = "jdbc:h2:file:" +
                            "./xa-transactions/testdb1", user = "test",
                            password = "test", options =
                            {datasourceName: xaDatasourceName});
    // The JDBC Client for the second H2 database.
    jdbc:Client dbClient2 = check new (url = "jdbc:h2:file:" +
                            "./xa-transactions/testdb2", user = "test",
                            password = "test", options =
                            {datasourceName: xaDatasourceName});

    // Create the `Employee` table in the first database.
    _ = check dbClient1->execute("CREATE TABLE IF NOT EXISTS EMPLOYEE " +
                                  "(ID INT, NAME VARCHAR(30))");
    // Create the `Salary` table in the second database.
    _ = check dbClient2->execute("CREATE TABLE IF NOT EXISTS SALARY " +
                                 "(ID INT, VALUE FLOAT)");

    // Populate the tables with the records.
    var e1 = check dbClient1->execute("INSERT INTO EMPLOYEE " +
                                      "VALUES (1, 'Anne')");
    var e2 = check dbClient2->execute("INSERT INTO SALARY " +
                                      "VALUES (1, 25000.00)");

    // The transaction block initiates the transaction.
    transaction {
        // Execute the database operations within the transaction
        // to update records in the `Employee` and `Salary` tables.
        var customer = dbClient1->execute("UPDATE EMPLOYEE " +
                                       "SET NAME='Annie' WHERE ID=1");
        var salary = dbClient2->execute("UPDATE SALARY " +
                                       "SET VALUE=30000 WHERE ID=1");

        // Return information about the current transaction.
        transactions:Info transInfo = transactions:info();
        io:println("Transaction Info: ", transInfo);

        // Perform the commit operation of the current transaction.
        var commitResult = commit;
        if commitResult is () {
            // Operations to be executed if the transaction is committed
            // successfully.
            io:println("Transaction committed");
            io:println("Employee Updated: ", customer);
            io:println("Salary Updated: ", salary);
        } else {
            // Operations to be executed if the transaction commit failed.
            io:println("Transaction failed");
        }
    }

    // Close the JDBC clients.
    checkpanic dbClient1.close();
    checkpanic dbClient2.close();
}
