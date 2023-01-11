import ballerina/io;

public function main() {

    // This will create 2 variables named `id` and `firstname` with the types
    // `int` and `string`. The string value `"Doe"` returned from `getDetails()` 
    // is ignored using `_`.
    [int, [string, string]] [id, [firstname, _]] = getDetails();

    io:println(id);
    io:println(firstname);
}

function getDetails() returns [int, [string, string]] {
    return [1234, ["John", "Doe"]];
}
