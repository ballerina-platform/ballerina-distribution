import ballerina/io;

type Cloneable object {
    function clone() returns Cloneable;
};

type Person object {
    // The `Cloneable` object type is included as a part of the interface of
    // the `Person` object type.
    *Cloneable;

    string name;

    // `getName()` is a part of `Person`'s own type.
    // The `clone()` function is also included from the `Cloneable` type.
    function getName() returns string;
};

class Engineer {
    // The `Engineer` class includes the `Person` object type.
    // Therefore, it has to implement both the `clone()` and `draw()` methods.
    *Person;

    function init(string name) {
        // `name` field is included from `Person` type.
        self.name = name;
    }

    // Returning `Engineer` is valid as the `Engineer` type becomes a subtype of the `Cloneable` type
    // once it includes the `Cloneable` object type.
    function clone() returns Engineer {
        return new (self.name);
    }

    function getName() returns string {
        return self.name;
    }
}

public function main() {
    Engineer engineer = new Engineer("Walter White");
    io:println(engineer.getName());

    Engineer engineerClone = engineer.clone();
    io:println(engineerClone.getName());

    io:println(engineer === engineerClone);
}
