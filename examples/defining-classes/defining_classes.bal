import ballerina/io;

class Engineer {
    // A `final` field must be assigned exactly once.
    final string name;

    int age;

    // `init` method initializes the object.
    function init(string name, int age) {
        // The `init` method can initialize the final field.
        self.name = name;
        self.age = age;
    }

    function getName() returns string {
        // Methods use `self` to access their fields.
        return self.name;
    }

    function getAge() returns int {
        return self.age;
    }
}

public function main() {
    // Arguments to `new` are passed as arguments to `init`.
    Engineer engineer = new Engineer("Alice", 52);

    io:println(engineer.getName());
    io:println(engineer.getAge());
}
