import ballerina/io;

public function main() returns error? {
    // Short for retry<DefaultRetryManager>(3)
    // If any of `doStage1` and `doStage2` returns  `error:Retriable`,
    // program will retry execution until execution succeed without an error `error:Retriable`.
    // By default, it will retry 3 times with `DefaultRetryManager`.
    retry transaction {
        check doStage1();
        check doStage2();
        check commit;
    }
}

function doStage1() returns error? {
    io:println("Stage1 completed");
}

function doStage2() returns error? {
    // Returns `error:Retriable` error for retrying.
    // To support custom errors, a custom implementation of `RetryManager` is required.
    return error 'error:Retriable("Stage2 failed");
}
