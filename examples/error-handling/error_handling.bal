import ballerina/io;

// Converts bytes to a string and then to an int.
function intFromBytes(byte[] bytes) returns int|error {

    string|error ret = string:fromBytes(bytes);

    // The `is` operator can be used to distinguish errors
    // from other values.
    if ret is error {

        return ret;
    } else {
        return int:fromString(ret);
    }
}

// The `main` function can return an error.
public function main() returns error? {

    int|error res = intFromBytes([104, 101, 108, 108, 111]);    
    if res is error {
        // The `check` expression is shorthand for this pattern of
        // checking if a value is an error and returning that value.
        return res;

    } else {
        io:println("result: ", res);
        return;
    }
}
