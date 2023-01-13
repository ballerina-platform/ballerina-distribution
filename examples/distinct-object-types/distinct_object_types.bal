import ballerina/io;

// The `Person` object type that contains a string field called `name`.
type Person distinct object {
    public string name;
};

// The `Engineer` and `Manager` classes are structurally the same but introducing the
// `distinct` keyword distinguishes them by considering them as nominal types.
distinct class Engineer {
    *Person;

    function init(string name) {
        self.name = name;
    }
}

distinct class Manager {
    *Person;

    function init(string name) {
        self.name = name;
    }
}

public function main() {
    Person person = new Engineer("Alice");
    // The `is` operator can be used to distinguish distinct subtypes.
    io:println(person is Engineer ? "Engineer" : "Manager");
}
