import ballerina/graphql;

// All the types that are used in the GraphQL service can have doc comments to add as documentation.
# Represents a profile.
# + name - The name of the profile
# + age - The age of the profile
type Profile record {|
    string name;
    int age;
|};

service /graphql on new graphql:Listener(9090) {

    // Add doc comments to reflect them in the generated GraphQL schema.
    # Returns a profile using the provided ID.
    # + id - The ID of the profile
    # + return - The profile with the requested ID
    resource function get profile(int id) returns Profile? {
        if id == 1 {
            return {name: "Walter White", age: 52};
        } else if id == 2 {
            return {name: "Jesse Pinkman", age: 25};
        }
        return;
    }
}
