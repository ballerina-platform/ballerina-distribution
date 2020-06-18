import ballerina/io;

function getAccountBalance(int accountID) returns int|error {
    if (accountID < 0) {
        // Return an error with "Invalid account ID" as the error message.
        return error("Invalid account ID", accountID = accountID);
    } else if (accountID > 100) {
        // Return an error with "Account not found" as the error message if `accountID` is greater than hundred.
        return error("Account not found", accountID = accountID);
    }
    // Return a value if `accountID` is in between zero and hundred inclusive.
    return 600;
}

public function main() {
    // Define an error value using the default error constructor.
    // The error message is the first positional argument to the error constructor
    // and the type of the message must be a subtype of `string`.
    // An optional positional argument can be used to specify the error cause, the error cause must be a
    // subtype of error.
    // Additional fields providing more details can be passed as named arguments to the constructor
    // and the type of each of those must be a subtype of `anydata|readonly`.
    error simpleError = error("Simple error occurred");

    // Print the error reason and the `message` field from the error detail.
    // The `.message()`, `.cause()`, and `.detail()` methods can be invoked on error values
    // to retrieve the error message, error cause, and details of the error.
    io:println("Error: ", simpleError.message());

    int|error result = getAccountBalance(-1);
    // If the `result` is an `int`, then print the value.
    if (result is int) {
        io:println("Account Balance: ", result);
    // If an error is returned, print the reason and the account ID from the detail record.
    // Each additional error detail field provided to the error constructor is available as a field in the error detail record.
    } else {
        io:println("Error: ", result.message(),
                    ", Account ID: ", result.detail()["accountID"]);
        // Provide error cause second positional argument to error constructor
        error displayError = error("Failed to get account balance", result);

        // Get error cause using `.cause()` method.
        error? cause = displayError.cause();
        if (cause is error) {
            io:println("Caused by: ", cause.message());
        } else {
            io:println("Error cause not provided.");
        }
    }
}
