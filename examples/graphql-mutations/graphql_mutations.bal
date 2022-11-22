import ballerina/graphql;

// Define a record type to use as an object in the GraphQL service.
type Person record {|
    string name;
    int age;
|};

service /graphql on new graphql:Listener(4000) {

    // Define a `Person` object in the service.
    private Person person;

    function init() {
        // Initializes the `person` value.
        self.person = {name: "Walter White", age: 51};
    }

    // A resource function represents a field in the root `Query` operation.
    resource function get profile() returns Person {
        return self.person;
    }

    // A remote function represents a field in the root `Mutation` operation. After updating the
    // name, the `person` object will be returned.
    remote function updateName(string name) returns Person {
        self.person.name = name;
        return self.person;
    }
}
