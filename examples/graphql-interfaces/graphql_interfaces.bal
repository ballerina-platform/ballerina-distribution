import ballerina/graphql;

service /graphql on new graphql:Listener(4000) {

    // This resource function returns an array of the `Character` interface
    // type.
    resource function get characters() returns Character[] {
        return [new Human("Luke Skywalker", 1), new Droid("R2D2", 1977)];
    }
}

// A GraphQL interface can be defined using a distinct service class.
// Each resource function in the class maps to a field in the interface.
public distinct service class Character {

    final string name;

    public function init(string name) {
        self.name = name;
    }

    // Every class that implements this class must have this resource
    // function.
    resource function get name() returns string {
        return self.name;
    }
}

// A GraphQL object that implements an interface must be a distinct service
// class in Ballerina. Type inclusion is used to mark it as an interface
// implementation. The implementing classes must contain all the resource
// functions in the interface class and it can have additional resource
// functions.
public distinct service class Human {

    // Marks this is an implementation of the `Character` interface.
    *Character;

    final string name;
    final int id;

    public function init(string name, int id) {
        self.name = name;
        self.id = id;
    }

    // This is a common field in the interface type. This resource function
    // must be implemented here.
    resource function get name() returns string {
        return self.name;
    }

    // An additional field that does not exist in the interface type.
    resource function get id() returns int {
        return self.id;
    }
}

// Another object implementing the `Character` interface.
public distinct service class Droid {
    *Character;

    final string name;
    final int year;

    public function init(string name, int year) {
        self.name = name;
        self.year = year;
    }

    resource function get name() returns string {
        return self.name;
    }

    resource function get year() returns int {
        return self.year;
    }
}
