import ballerina/io;

function foo(string s) returns error|int {
    var res = int:fromString(s);
    if res is error {
        // The error constructor is called with the additional argument `res`, which is the
        // error returned in case the `int:fromString()` function returns an error
        // This creates an error with a specified error and cause.
        return error("not an integer", res);
    } else {
        return res;
    }
}

public function main() {
    error|int result = foo("1.1");
    io:println(result);

    if (result is error) {
        // The lang library function `error:cause()` can be used to
        // extract the cause from an error
        io:println(result.cause());
    }
}
