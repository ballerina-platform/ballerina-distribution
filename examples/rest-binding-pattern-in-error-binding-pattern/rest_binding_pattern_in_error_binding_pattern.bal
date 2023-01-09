import ballerina/io;

type SampleErrorData record {|
    int code;
    string reason;
|};

type SampleError error<SampleErrorData>;

public function main() {
    // The detail mapping can be destructured using a rest parameter.
    // `details` is of type `map<string|boolean>` having the `code` and `reason` fields.
    var error(message, ...details) = getSampleError();
    io:println("Message: ", message);

    map<int|string> detailsMap = details;
    io:println("Details: ", detailsMap);

    // Here, the rest parameter `...filteredDetails` only contains the detail fields
    // that are not matched.
    var error(_, code = code, ...filteredDetails) = getSampleError();
    io:println("Code: ", code);
    io:println("Filtered Details: ", filteredDetails);

    map<int|string> moreDetails;

    // The detail mapping can be destructured into a `map<int|string>` typed variable
    // by using a rest parameter.
    error(_, ...moreDetails) = getSampleError();
    io:println("All Details: ", moreDetails);
}

function getSampleError() returns SampleError {
    return error("Transaction Failure", error("Database Error"), code = 20,
                            reason = "deadlock condition");
}
