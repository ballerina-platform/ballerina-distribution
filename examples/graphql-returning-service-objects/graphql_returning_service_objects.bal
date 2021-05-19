import ballerina/graphql;

service graphql:Service /graphql on new graphql:Listener(4000) {

    // Resource functions can return service objects. The returning service
    // object is mapped to an `OBJECT` type in GraphQL. Each resource
    // function is mapped to a field in the `OBJECT`.
    isolated resource function get profile() returns Person {

        return new("Walter White", 51);
    }
}

// Define a service class to use in GraphQL service.
service class Person {
    private string name;
    private int age;

    isolated function init(string name, int age) {
        self.name = name;
        self.age = age;
    }

    // Each resource function becomes a field of the `Person` type.
    isolated resource function get name() returns string {
        return self.name;
    }
    isolated resource function get age() returns int {
        return self.age;
    }
    isolated resource function get isAdult() returns boolean {
        return self.age > 21;
    }
}
