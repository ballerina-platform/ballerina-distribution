import ballerina/io;

class Person {
    public string name;

    function init(string name) {
        self.name = name;
    }
};

// The `DistinctPerson` type is a proper subtype of the `Person` type.
distinct class DistinctPerson {
    public string name;

    function init(string name) {
        self.name = name;
    }
}

// The `SomeWhatDistinctPerson` type is a subtype of the `DistinctPerson` type
// since it includes the `DistinctPerson` type's type IDs via inclusion.
class SomeWhatDistinctPerson {
    *DistinctPerson;

    public string name;

    function init(string name) {
        self.name = name;
    }
}

// The `EvenMoreDistinctPerson` type is a proper subtype of the `DistinctPerson` 
// type since it has an additional type ID.
distinct class EvenMoreDistinctPerson {
    *DistinctPerson;

    public string name;

    function init(string name) {
        self.name = name;
    }
}

public function main() {
    Person person = new ("John Smith");
    io:println(person is DistinctPerson);

    DistinctPerson distinctPerson = new ("Alice Johnson");
    io:println(distinctPerson is Person);

    SomeWhatDistinctPerson someWhatDistinctPerson = new ("Michael Brown");
    io:println(someWhatDistinctPerson is DistinctPerson);
    io:println(distinctPerson is SomeWhatDistinctPerson);

    EvenMoreDistinctPerson evenMoreDistinctPerson = new ("Sarah Wilson");
    io:println(evenMoreDistinctPerson is DistinctPerson);
    io:println(distinctPerson is EvenMoreDistinctPerson);
}
