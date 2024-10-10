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

    map<string?> grades1 = {
        math: "80",
        physics: (),
        chemistry: "76"
    };
    // Parsing a map with grades values that are either the string
    // representation of an integer or nil results in a map of
    // the just the non-nil grades as integers.
    map<int>|error parseGrades1 = parseGrades(grades1);
    io:println(parseGrades1);

    map<string> grades2 = {
        math: "80",
        physics: "N/A",
        chemistry: "76"
    };
    // Attempting to parse a map with string values that
    // are not the string representation of a number results
    // in the function terminating early, returning the error.
    map<int>|error parseGrades2 = parseGrades(grades2);
    io:println(parseGrades2);
}

function nameToString(Name nm) returns string {
    // Checks whether `nm` belongs to `string` type.
    if nm is string {
        // The type of `nm` is narrowed to `string` here.
        // Therefore, you can directly return `nm` from this
        // function that specifies `string` as the return type.
        return nm;
    } else {
        // The type of `nm` is narrowed to `StructuredName` here.
        // Therefore, you can directly access fields defined in
        // the `StructuredName` record.
        return nm.firstName + " " + nm.lastName;
    }
}

function parseGrades(map<string?> grades) returns map<int>|error {
    map<int> parsedGrades = {};

    foreach [string, string?] [subject, grade] in grades.entries() {
        // If the `grade` value is `()`, continue on to the next entry.
        if grade is () {
            continue;
        }

        // The type of `grade` is narrowed to `string` here
        // since we won't reach here if the value is `()`, due
        // to the `continue` statement above.
        // Therefore, we can directly use `grade` where a `string`
        // value is expected.
        int|error parsedGrade = int:fromString(grade);

        // If the `parsedGrade` value is an error value terminate the
        // execution of this function and return the error value.
        if parsedGrade is error {
            return parsedGrade;
        }

        // Since we return the error from the function if `parsedGrade` is `error`,
        // the type of `parsedGrade` is narrowed to `int` here,
        // allowing it to be used as an `int`-typed variable when adding
        // the value to a map of integers.
        parsedGrades[subject] = parsedGrade;
    }

    return parsedGrades;
}
