
import ballerina/io;

public function main() {

    // This will create 3 variables `id`, `firstname` and `lastname` with the following types.
    [int, [string, string]] [id, [firstname, lastname]] = getDetails();

    io:println(id);
    io:println(firstname);
    io:println(lastname);
}

function getDetails() returns [int, [string, string]] {
    return [1234, ["John", "Doe"]];
}
