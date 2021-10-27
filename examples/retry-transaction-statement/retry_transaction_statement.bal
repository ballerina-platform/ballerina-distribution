import ballerina/io;

public function main() returns error? {
    // Short for `retry<DefaultRetryManager>(3)`.
    // If any of the `doStage1` and `doStage2` returns  `error:Retriable`,
    // the program will retry execution until execution succeeds without an `error:Retriable` error.
    // By default, it will retry 3 times with the `DefaultRetryManager`.
    retry transaction {
        check doStage1();
        check doStage2();
        check commit;
    }

    return;
}

function doStage1() returns error? {
    io:println("Stage1 completed");
    return;
}

function doStage2() returns error? {
    // Returns `error:Retriable` error for retrying.
    // To support custom errors, a custom implementation of the `RetryManager` is required.
    return error 'error:Retriable("Stage2 failed");

}
