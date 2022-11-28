import ballerina/graphql;

// Define a record type to use as an object in the GraphQL service.
type Profile record {|
    string name;
    int age;
|};

service /graphql on new graphql:Listener(9090) {

    // Define a `Profile` object in the service.
    private Profile profile;

    function init() {
        // Initializes the `profile` value.
        self.profile = {name: "Walter White", age: 51};
    }

    // A resource method represents a field in the root `Query` operation.
    resource function get profile() returns Profile {
        return self.profile;
    }

    // A remote method represents a field in the root `Mutation` operation. After updating the name,
    // the `profile` object will be returned.
    remote function updateName(string name) returns Profile {
        self.profile.name = name;
        return self.profile;
    }
}
