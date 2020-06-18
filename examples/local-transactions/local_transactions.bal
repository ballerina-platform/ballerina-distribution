import ballerina/lang.'transaction as transactions;
import ballerina/io;
import ballerina/sql;
import ballerina/java.jdbc;

public function main() returns error? {
    // The JDBC Client for the H2 database.
    jdbc:Client dbClient =
                check new (url = "jdbc:h2:file:./local-transactions/testdb",
                                        user = "test", password = "test");

    // Create the tables that are required for the transaction.
    var ret = dbClient->execute("CREATE TABLE IF NOT EXISTS CUSTOMER " +
                                "(ID INTEGER, NAME VARCHAR(30))");
    handleExecute(ret, "Create CUSTOMER table");

    ret = dbClient->execute("CREATE TABLE IF NOT EXISTS SALARY " +
                                "(ID INTEGER, MON_SALARY FLOAT)");
    handleExecute(ret, "Create SALARY table");

    // This is a `transaction` statement block. It is a must to have either
    // a commit action or a rollback statement in it. The transaction scope ends after
    // the commit action or rollback statement.
    transaction {
        // This is the first remote function participant of the transaction.
        var customerResult =
                        dbClient->execute("INSERT INTO CUSTOMER(ID,NAME) " +
                                        "VALUES (1, 'Anne')");

        // This is the second remote function participant of the transaction.
        var salaryResult =
                        dbClient->execute("INSERT INTO SALARY(ID, MON_SALARY)" +
                                        " VALUES (1, 2500)");

        // Returns information about the current transaction.
        transactions:Info transInfo = transactions:info();
        io:println(transInfo);

        // The `commit` action performs the commit operation of the current transaction.
        // The result of the commit action is an error. Otherwise, the result is `()`.
        var commitResult = commit;

        // Based on the result of the `commit` action, the followup tasks could be performed.
        if(commitResult is ()){
            // Any action that needs to be performed after the transaction, which is
            // committed should be added here.
            io:println("Transaction committed");
            handleExecute(customerResult, "Insert data into CUSTOMER table");
            handleExecute(salaryResult, "Insert data into SALARY table");
        } else {
            // If the transaction is failed, any action that needs to perform
            // after the commit failure should be added here.
            io:println("Transaction failed");
        }
    }

    //Drop the tables.
    ret = dbClient->execute("DROP TABLE CUSTOMER");
    handleExecute(ret, "Drop table CUSTOMER");

    ret = dbClient->execute("DROP TABLE SALARY");
    handleExecute(ret, "Drop table SALARY");

    // Close the JDBC client.
    check dbClient.close();
}

 //Function to handle the return value of the `execute` remote function.
function handleExecute(sql:ExecutionResult|sql:Error returned, string message) {
    if (returned is sql:ExecutionResult) {
        io:println(message + " status: ", returned.affectedRowCount);
    } else {
        io:println(message + " failed: ", returned.message());
    }
}
