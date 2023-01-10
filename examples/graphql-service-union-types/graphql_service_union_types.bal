import ballerina/graphql;

// Defines the `SearchResult` union type that includes the `Profile` and the `Address` types.
type SearchResult Profile|Address;

// Defines the `Profile` class to represent the `Profile` object.
distinct service class Profile {
    private final string name;
    private final int age;

    function init(string name, int age) {
        self.name = name;
        self.age = age;
    }

    // Defines the fields of the `Profile` object.
    resource function get name() returns string {
        return self.name;
    }

    resource function get age() returns int {
        return self.age;
    }
}

// Defines the `Address` class to represent the `Address` object.
distinct service class Address {
    private final int number;
    private final string street;
    private final string city;

    function init(int number, string street, string city) {
        self.number = number;
        self.street = street;
        self.city = city;
    }

    resource function get number() returns int {
        return self.number;
    }

    resource function get street() returns string {
        return self.street;
    }

    resource function get city() returns string {
        return self.city;
    }
}

service /graphql on new graphql:Listener(9090) {

    // The return type `SearchResult[]` will allow to return an array consisting both `Profile` and
    // `Address` values.
    resource function get search(string keyword) returns SearchResult[] {
        return [new ("Walter White", 50), new (308, "Negro Arroyo Lane", "Albuquerque")];
    }
}
