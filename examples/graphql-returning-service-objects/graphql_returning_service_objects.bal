import ballerina/graphql;

service /graphql on new graphql:Listener(4000) {

    // This resolver returns a service type, which will be mapped to a GraphQL `OBJECT` type named
    // `Person`. Each resource function in the service type is mapped to a field in the `OBJECT`
    // type.
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
