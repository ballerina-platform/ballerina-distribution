import ballerina/graphql;

service /graphql on new graphql:Listener(4000) {

    // Resource functions can return service objects. The returning service
    // object is mapped to an `OBJECT` type in GraphQL. Each resource
    // function is mapped to a field in the `OBJECT`.
    resource function get profile() returns Person {

        return new("Walter White", 51);
    }
}

// Define a service class to use as an object in the GraphQL service.
service class Person {
    private final string name;
    private final int age;

    function init(string name, int age) {
        self.name = name;
        self.age = age;
    }

    // Each resource function becomes a field of the `Person` type.
    resource function get name() returns string {
        return self.name;
    }
    resource function get age() returns int {
        return self.age;
    }
    resource function get isAdult() returns boolean {
        return self.age > 21;
    }
}
