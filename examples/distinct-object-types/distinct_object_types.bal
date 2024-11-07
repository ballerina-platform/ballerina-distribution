import ballerina/io;

// DistinctPerson is a proper subtype of Person
class Person {
    public string name;

    function init(string name) {
        self.name = name;
    }
};

distinct class DistinctPerson {
    public string name;

    function init(string name) {
        self.name = name;
    }
}

// SomeWhatDistinctPerson is a subtype of DistinctPerson since inherit the same type ID via inclusion
class SomeWhatDistinctPerson {
    *DistinctPerson;
    public string name;

    function init(string name) {
        self.name = name;
    }
}

// EvenMoreDistinctPerson is a proper subtype of DistinctPerson since it has a additional type ID
distinct class EvenMoreDistinctPerson {
    *DistinctPerson;
    public string name;

    function init(string name) {
        self.name = name;
    }
}

public function main() {
    Person person = new ("person");
    io:println(person is DistinctPerson);
    DistinctPerson distinctPerson = new ("distinctPerson");
    io:println(distinctPerson is Person);

    SomeWhatDistinctPerson someWhatDistinctPerson = new ("someWhatDistinctPerson");
    io:println(someWhatDistinctPerson is DistinctPerson);
    io:println(distinctPerson is SomeWhatDistinctPerson);

    EvenMoreDistinctPerson evenMoreDistinctPerson = new ("evenMoreDistinctPerson");
    io:println(evenMoreDistinctPerson is DistinctPerson);
    io:println(distinctPerson is EvenMoreDistinctPerson);
}
