import ballerina/graphql;

// Define the custom record types for the returning data.
public type Profile record {|
    string name;
    int age;
    Address address;
|};

public type Address record {|
    string number;
    string street;
    string city;
|};

service /graphql on new graphql:Listener(9090) {

    // Ballerina GraphQL resolvers can return `record` values. The record will be mapped to a
    // GraphQL output object type in the generated GraphQL schema with the same name and fields.
    resource function get profile() returns Profile {
        return {
            name: "Walter White",
            age: 51,
            address: {
                number: "308",
                street: "Negra Arroyo Lane",
                city: "Albuquerque"
            }
        };
    }
}
