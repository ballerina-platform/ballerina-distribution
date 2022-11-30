import ballerina/graphql;

// Define a service class to use as an object in the GraphQL service.
service class Profile {
    private final string name;
    private final int age;

    function init(string name, int age) {
        self.name = name;
        self.age = age;
    }

    // Each resource method becomes a field of the `Profile` type.
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

service /graphql on new graphql:Listener(9090) {

    // This resolver returns a service type, which will be mapped to a GraphQL `OBJECT` type named
    // `Profile`. Each resource method in the service type is mapped to a field in the `OBJECT`
    // type.
    resource function get profile() returns Profile {
        return new ("Walter White", 51);
    }
}
