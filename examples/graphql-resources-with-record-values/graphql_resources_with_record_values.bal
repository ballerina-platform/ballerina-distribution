import ballerina/graphql;
import ballerina/http;

// Create an `http:Listener`.
http:Listener httpListener = check new(9090);

// The `graphql:Service` exposes a GraphQL service on the provided HTTP listener.
service graphql:Service /graphql on new graphql:Listener(httpListener) {

    // Ballerina GraphQL resolvers can return `anydata` values with union of
    // `error`s.
    // Each field of the `Person` object can be queried by a GraphQL client.
    resource function get profile(int id) returns Person|error {

        if (id < people.length()) {
            return people[id];
        } else {
            return error("Person with id " + id.toString() + " not found");
        }
    }
}

// Define the custom record types to return data.
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

// Define an array of `Person` records.
Person p1 = {
    name: "Sherlock Holmes",
    age: 40,
    address: {
        number: "221/B",
        street: "Baker Street",
        city: "London"
    }
};
Person p2 = {
    name: "Walter White",
    age: 50,
    address: {
        number: "308",
        street: "Negra Arroyo Lane",
        city: "Albuquerque"
    }
};
Person p3 = {
    name: "Tom Marvolo Riddle",
    age: 100,
    address: {
        number: "Uknown",
        street: "Unknown",
        city: "Hogwarts"
    }
};
Person[] people = [p1, p2, p3];
