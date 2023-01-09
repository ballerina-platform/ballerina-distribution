import ballerina/io;

type DatabaseErrorDetail record {|
    int code;
    string reason;
|};

type NetworkErrorDetail record {|
    string 'type;
    string phase;
    int elapsedTime;
|};

type DatabaseError error<DatabaseErrorDetail>;

type NetworkError error<NetworkErrorDetail>;

const ERROR = "Generic Error";

function errorMatch(error v) {
    match v {
        // This error binding pattern matches a `DatabaseError` type error value and
        // binds its `code` detail mapping to the `code` variable.
        var error DatabaseError(code = code) => {
            io:println("Matched DatabaseError with code:", code);
        }
        // This error binding pattern matches an error value with an `ERROR` error message and
        // binds its `code` detail mapping to the `code` variable.
        var error(ERROR, code = code) => {
            io:println("Matched Generic Error with message:", ERROR, " and code:", code);
        }
        // This error binding pattern matches the value of the error message in an error with the `message`
        // variable, the value of the `type` field in the detail mapping is matched with the `errorType` variable, and
        // the `...otherDetails` rest parameter is matched with the remaining detail fields.
        var error(message, 'type = errorType, ...otherDetails) => {
            io:println("Matched NetworkError with message:", message, ", type:", errorType, ", phase:",
                    otherDetails["phase"], " and elapsedTime:", otherDetails["elapsedTime"]);
        }
    }
}

public function main() {
    error e1 = error("Generic Error", code = 20);
    DatabaseError e2 = error("Database Error", code = 2, reason = "connection failure");
    NetworkError e3 = error NetworkError("Bad Request", 'type = "http error", phase = "application",
                                    elapsedTime = 338);
    errorMatch(e1);
    errorMatch(e2);
    errorMatch(e3);
}
