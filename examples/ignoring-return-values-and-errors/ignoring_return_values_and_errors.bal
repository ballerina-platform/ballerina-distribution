import ballerina/io;

public function main() {
    // Allowed only if the return value is `()`.
    doX();

    // Allowed if the return value does not include an `error`.
    _ = getX();

    // Use `checkpanic` if you don't want to handle an `error`.
    checkpanic tryX(true);
    checkpanic tryX(false);

}

function doX() {
    io:println("Do X");
}

function getX() returns boolean {
    io:println("Get X");
    return true;
}

function tryX(boolean x) returns error? {
    io:println("Try X");
    if !x {
        return error("error!");
    }
    return;
}
