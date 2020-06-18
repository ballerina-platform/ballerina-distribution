import ballerina/lang.'transaction as transactions;
import ballerina/io;

public function main() {

    // The `transaction` block initiates the transaction.
    transaction {

        // Defines the rollback handler, which is triggered once the
        // rollback statement is executed.
        var onRollbackFunc = function(transactions:Info info,
                                error? cause, boolean willRetry) {
            io:println("Rollback handler #1 executed.");
        };

        var onRollbackFunc2 = function(transactions:Info info,
                                        error? cause, boolean willRetry) {
            io:println("Rollback handler #2 executed.");
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
        transactions:onRollback(onRollbackFunc2);

        // Register commit handler to the transaction context.
        // Multiple commit handlers can be registered and they
        // are executed in reverse order.
        transactions:onCommit(onCommitFunc);

        // Returns information about the current transaction
        transactions:Info transInfo = transactions:info();
        io:println(transInfo);

        // Invokes the local participant.
        var res = trap throwError();
        if (res is error) {
            // The local participant gets panicked.
            io:println("Local participant panicked.");
            rollback;
        } else {
            io:println("Local participant successfully executed.");
            var commitRes = commit;
        }
    }
}

// Method which throws error
function throwError() {
    io:println("Invoke local participant function.");
    error er = error("Simulated Failure");
    panic er;
}
