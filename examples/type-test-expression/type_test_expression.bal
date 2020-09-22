import ballerina/io;

public function main() {
    any message = "Hello, world!";

    // Checks whether the actual value of the `any` type variable is a `string`.
    boolean isString = message is string;
    io:println("Is 'message' a string? ", isString);

    // The type test can be used as a condition of an `if` statement.
    if (message is int) {
        io:println("'message' is an int with value: ", message);
    } else if (message is string) {
        io:println("'message' is a string with value: ", message);
    } else {
        io:println("'message' is not an int or string, and has the value: ", message);
    }

    // The type test can be used to find the runtime type of union type variables.
    Student alex = { name: "Alex" };
    Student|Person|Vehicle entity = alex;

    // Type of `entity` is `Student`. Therefore, the `if` check will pass.
    if (entity is Student) {
        io:println("entity is a student");
    } else {
        io:println("entity is not a student");
    }

    // Type of `entity` is `Student`. However, it is structurally equivalent to `Person`.
    // Therefore, the `if` check will pass.
    if (entity is Person) {
        io:println("entity is a person");
    } else {
        io:println("entity is not a person");
    }

    // Type of `entity` is Student. However, it is not structurally equivalent to `Vehicle`.
    if (entity is Vehicle) {
        io:println("entity is a vehicle");
    } else {
        io:println("entity is not a vehicle");
    }

    // The type test expression can be used with any expression.
    boolean isStudent = createEntity("student") is Student;
    io:println("Did createEntity(\"student\") return a student? ", isStudent);
    isStudent = createEntity("vehicle") is Student;
    io:println("Did createEntity(\"vehicle\") return a student? ", isStudent);
}

type Person record {
    string name;
};

type Student record {
    string name;
    int age = 0;
};

type Vehicle record {
    string brand;
};

function createEntity(string entityType) returns any {
    if (entityType == "student") {
        return <Student> { name: "Alex" };
    } else if (entityType == "vehicle") {
        return <Vehicle> { brand: "Honda" };
    }
    return "invalid type";
}
