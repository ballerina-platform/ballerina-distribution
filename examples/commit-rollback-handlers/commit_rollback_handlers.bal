import ballerina/io;

public function main() returns error? {
    transaction {
        check update();
        check commit;
    }
    return;
}

transactional function update() returns error? {
    check updateDatabase();
    //  Registers a commit handler to be invoked when the `commit` is executed.
    'transaction:onCommit(sendEmail);
    'transaction:onRollback(logError);
}

function updateDatabase() returns error? {
    io:println("Database updated");
    return;
}

isolated function sendEmail('transaction:Info info) {
    io:println("Email sent.");
}

isolated function logError('transaction:Info info,
                            error? cause, boolean willRetry) {
    io:println("Logged database update failure");
}
