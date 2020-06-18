import ballerina/io;

public function main() returns error?{

    string str = "start";
    int count = 0;

    // The retry statement provides a general-purpose retry
    // facility, which is independent of the transactions.
    // Here, retrying happens according to the default retry manager
    // since there is no custom retry manager being passed to 
    // the retry operation.
    // As defined, retrying happens for 3 times.
    retry (3) {
        count = count + 1;
        if (count < 3) {
            str += (" attempt " + count.toString() + ":error,");

            // Calls a method, which throws an error to simulate the
            // retry operation.
            return trxError();
        }

        str += (" attempt "+ count.toString() + ":result returned end.");

        // Prints the execution flow as string for clarification.
        io:println(str);
    }
}

// Method which throws error
function trxError()  returns error {
    return error("RetryError");
}
