import ballerina/graphql;

service /graphql on new graphql:Listener(4000) {

    // Ballerina GraphQL resolvers can return `record` values. The record will be mapped to an `OBJECT` type.
    resource function get profile() returns Person {

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

// Define the custom record types for the returning data.
public type Person record {
    string name;
    int age;
    Address address;
};
public type Address record {
    string number;
    string street;
    string city;
};
