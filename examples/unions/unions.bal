import ballerina/io;

type StructuredName record {
    string firstName;
    string lastName;
};

// A `Name` type value can be either a `StructuredName` or a `string`.
type Name StructuredName|string;

public function main() {
    // `name1` is a `StructuredName`.
    Name name1 = {
        firstName: "Rowan",
        lastName: "Atkinson"
    };
    // `name2` is a `string`.
    Name name2 = "Leslie Banks";

    io:println(nameToString(name1));
    io:println(nameToString(name2));
}

function nameToString(Name nm) returns string {
    // Checks whether `nm` belongs to `string` type.
    if nm is string {

        return nm;
    } else {
        return nm.firstName + " " + nm.lastName;
    }
}
