import ballerina/graphql;

// Define the `NewProfile` record type to use as an input object.
type NewProfile record {|
    string name;
    int age;
|};

// Define the `Profile` record type to use as an output object.
type Profile readonly & record {|
    *NewProfile;
    int id;
|};

// Define an in-memory table to store the Profiles.
table<Profile> key(id) profiles = table [];

service /graphql on new graphql:Listener(9090) {

    // This remote method (`addProfile`) has an input argument `newProfile` of type `NewProfile!`.
    // This `NewProfile` record type will be mapped to an `INPUT_OBJECT` type in the generated
    // GraphQL schema. This method will take the next ID from the table and adds it to the `Profile`
    // record.
    remote function addProfile(NewProfile newProfile) returns Profile {
        Profile profile = {id: profiles.nextKey(), ...newProfile};
        profiles.add(profile);
        return profile;
    }

    // Query resolver to retrive all the profiles. A Ballerina GraphQL resolver can return a table
    // directly.
    resource function get profiles() returns table<Profile> {
        return profiles;
    }
}
