import ballerina/io;

type Person record {
    string name;
    int age;
};

function validatePeople(Person[] people) returns error? {
    if people.length() == 0 {
        // Create an error value specifying only the error message.
        return error("Expected a non-empty array");
    }

    foreach Person p in people {
        io:println("Validating ", p.name);
        error? err = validatePerson(p);
        if err is error {
            // Create a new error value with the validation error as the cause
            // and the `Person` value for which validation failed in the detail mapping.
            return error("Validation failed for a person", err, person = p);
        }
    }
}

function validatePerson(Person person) returns error? {
    int age = person.age;
    if age < 0 {
        // If validation fails for age, create a new error value specifying
        // an error message and the age value for which validation failed.
        return error("Age cannot be negative", age = age);
    }
}

public function main() {
    Person[] people = [
        {name: "Alice", age: 25},
        {name: "Bob", age: -1},
        {name: "Charlie", age: 30}
    ];
    // Note how the `Person` value after the value for which validation fails is
    // not processed.
    error? err = validatePeople(people);
    if err is error {
        printError(err);
    }
}

// Helper function to print internals of error value.
function printError(error err) {
    io:println("Message: ", err.message());
    io:println("Detail: ", err.detail());
    io:println("Stack trace: ", err.stackTrace());

    error? cause = err.cause();
    if cause is error {
        io:println("Cause:");
        printError(cause);
    }
}
