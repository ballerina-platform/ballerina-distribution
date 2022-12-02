import ballerina/graphql;

// Define a record type to use as an object in the GraphQL service.
type Profile readonly & record {|
    int id;
    string name;
    int age;
|};

// Define an in-memory table to store the profiles.
table<Profile> key(id) profiles = table [
        {id: 1, name: "Walter White", age: 50},
        {id: 2, name: "Jesse Pinkman", age: 25}
    ];

service /graphql on new graphql:Listener(9090) {
    // A resource method represents a field in the root `Query` operation.
    resource function get profile(int id) returns Profile {
        return profiles.get(id);
    }

    // A remote method represents a field in the root `Mutation` operation. This remote method will
    // update the name for the given profile ID, and returns the updated `Profile` value. If the ID
    // is not found, this will return an error.
    remote function updateName(int id, string name) returns Profile|error {
        if profiles.hasKey(id) {
            Profile profile = profiles.remove(id);
            Profile updatedProfile = {
                id: profile.id,
                name: name,
                age: profile.age
            };
            profiles.put(updatedProfile);
            return updatedProfile;
        }
        return error(string `Profile with ID "${id}" not found`);
    }
}
