import ballerina/graphql;

// Define the `NewProfile` record type to use as an input object.
type NewProfile record {|
    string name;
    int age;
|};

// Define the `Profile` record type to use as an output object.
type Profile record {|
    *NewProfile;
    int id;
|};

service /graphql on new graphql:Listener(9090) {

    // Define an in-memory array to store the Profiles.
    private final Profile[] profiles = [];

    // This remote method (`addProfile`) has an input argument `newProfile` of type `NewProfile!`.
    // This `NewProfile` record type will be mapped to an `INPUT_OBJECT` type in the generated
    // GraphQL schema.
    remote function addProfile(NewProfile newProfile) returns Profile {
        int id = self.profiles.length();
        Profile profile = {id: id, ...newProfile};
        self.profiles.push(profile);
        return profile;
    }

    // Query resolver to retrive all the profiles
    resource function get profiles() returns Profile[] {
        return self.profiles;
    }
}
