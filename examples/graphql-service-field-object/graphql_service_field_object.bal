import ballerina/graphql;
import ballerina/log;

// Define record types to use as an object in the GraphQL service.
// Note that the `address` field is optional. This way, the `address` field can be removed from the
// result if it is not needed.
type Profile readonly & record {|
    string name;
    int age;
    Address address?;
|};

type Address record {|
    int number;
    string street;
    string city;
|};

// Define an in-memory table to store the data.
table<Profile> key(name) profileTable = table [
    {
        name: "Walter White",
        age: 50,
        address: {number: 308, street: "Negra Arroyo Lane", city: "Albuquerque"}
    },
    {
        name: "Jesse Pinkman",
        age: 25,
        address: {number: 9809, street: "Margo Street", city: "Albuquerque"}
    }
];

service /graphql on new graphql:Listener(9090) {

    // If the field is needed, it should be defined as the first parameter of the resolver function.
    resource function get profile(graphql:Field 'field) returns Profile[]|error {
        // Check whether the `address` field is included in the subfiuelds.
        if 'field.getSubfieldNames().indexOf("address") !is int {
            // Add log message to check the behavior.
            log:printInfo("Address field is not queried");
            // If the `address` field is not needed, remove the `address` field from the query.
            return from Profile profile in profileTable
                select {
                    name: profile.name,
                    age: profile.age
                };
        }
        // Add log message to check the behavior.
        log:printInfo("Querying all the fields");
        return from Profile profile in profileTable
            select {
                name: profile.name,
                age: profile.age,
                address: profile.address
            };
    }
}
