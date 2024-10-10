import ballerina/io;

type Person record {
    string name;
    int age;
};

function validatePeople(Person[] people) returns error? {
    if people.length() == 0 {
        // Create error with only a message.
        return error("empty people array");
    }

    foreach Person p in people {
        error? err = validatePerson(p);
        if err != () {
            // Create a new error with previous error as the cause and people in the detail.
            return error("failed to validate people", err, people = people);
        }
    }
}

function validatePerson(Person person) returns error? {
    if person.age < 0 {
        // Create a new error we person in the detail to help debugging.
        return error("age cannot be negative", person = person);
    }
}

public function main() {
    Person[] people = [
        {name: "Alice", age: 25},
        {name: "Bob", age: -1}
    ];
    error? err = validatePeople(people);
    if err != () {
        printError(err);
    }
}

// Helper function to print internals of error value.
function printError(error err, int depth = 0) {
    string indent = "".join(...from int _ in 0 ..< depth
        select "    ");
    io:println(indent + "message: ", err.message());
    io:println(indent + "details: ", err.detail());
    io:println(indent + "stack trace: ", err.stackTrace());
    error? cause = err.cause();
    if cause != () {
        io:println(indent + "cause: ");
        printError(cause, depth + 1);
    }
}
