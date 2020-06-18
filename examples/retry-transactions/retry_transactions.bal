import ballerina/lang.'transaction as transactions;
import ballerina/io;
import ballerina/sql;
import ballerina/java.jdbc;

// The user-defined retry manager object.
public type MyRetryManager object {
   private int count;
   public function init(int count = 2) {
       io:println("Retry count: ", count);
       self.count = count;
   }
   public function shouldRetry(error? e) returns boolean {
     io:println("Retry count: ", self.count);
     if e is error && self.count >  0 {
        self.count -= 1;
        return true;
     } else {
        return false;
     }
   }
};

public function main() returns error? {
    // The JDBC client for the H2 database.
    jdbc:Client dbClient = check new (url = "jdbc:h2:file:./local-transactions/testdb",
                                        user = "test", password = "test");

    // Create the tables that are required for the transaction.
    var ret = dbClient->execute("CREATE TABLE IF NOT EXISTS DEPOSITS " +
                                "(ID INTEGER, AMOUNT FLOAT)");
    handleExecute(ret, "Create DEPOSITS table");

    ret = dbClient->execute("CREATE TABLE IF NOT EXISTS WITHDRAWALS " +
                                "(ID INTEGER, AMOUNT FLOAT)");
    handleExecute(ret, "Create WITHDRAWALS table");

    // This is a `retry transaction` statement block. A retry
    // transaction statement combines the retry statement and
    // the transaction statement with the additional semantics.
    // that each transaction is part of a sequence of retries.
    retry<MyRetryManager> (3) transaction {

        // Defines the rollback handler which triggered once
        // rollback statement is executed.
        var onRollbackFunc = function(transactions:Info info,
                                error? cause, boolean willRetry) {
            io:println("Rollback handler executed.");
        };

        // Defines the commit handler which triggered once commit
        // action is executed.
        var onCommitFunc = function(transactions:Info info) {
            io:println("Commit handler executed.");
        };

        // Register rollback handler to the transaction context.
        // Multiple rollback handlers can be registered and they
        // are executed in reverse order.
        transactions:onRollback(onRollbackFunc);

        // Register commit handler to the transaction context.
        // Multiple commit handlers can be registered and they
        // are executed in reverse order.
        transactions:onCommit(onCommitFunc);

        // This is the first remote function participant of the transaction.
        var withdrawalResult = dbClient->execute("INSERT INTO WITHDRAWALS(ID,AMOUNT) " +
                                        "VALUES (1234553, 10500)");

        // This is the second remote function participant of the transaction.
        var depositResult = dbClient->execute("INSERT INTO DEPOSITS (ID, AMOUNT) " +
                                        "VALUES (1234554, 10500)");

        // Returns information about the current transaction
        transactions:Info transInfo = transactions:info();
        io:println(transInfo.xid);

        if(withdrawalResult is error || depositResult is error) {
            check getError("DB operation failed");
        }

        // The `commit` action performs the commit operation of the current transaction.
        // The result of the commit action is an error. Otherwise, the result is `()`.
        var commitResult = commit;

        // Based on the result of the `commit` action, the followup tasks could be performed.
        if(commitResult is ()){
            // Any action that needs to be performed after the transaction, which is
            // committed should be added here.
            io:println("Transaction committed.");
            handleExecute(withdrawalResult, "Insert data into WITHDRAWALS table");
            handleExecute(depositResult, "Insert data into DEPOSITS table");
        } else {
            // If the transaction is failed, any action that needs to perform
            // after the commit failure should be added here.
            io:println("Transaction failed");
        }
    }

    //Drop the tables.
    ret = dbClient->execute("DROP TABLE WITHDRAWALS");
    handleExecute(ret, "Drop table WITHDRAWALS");

    ret = dbClient->execute("DROP TABLE DEPOSITS");
    handleExecute(ret, "Drop table DEPOSITS");

    // Close the JDBC client.
    check dbClient.close();
}

function getError(string message) returns error? {
    return error(message);
}

 //Function to handle the return value of the `execute` remote function.
function handleExecute(sql:ExecutionResult|sql:Error returned, string message) {
    if (returned is sql:ExecutionResult) {
        io:println(message + " status: ", returned.affectedRowCount);
    } else {
        io:println(message + " failed: ", returned.message());
    }
}
