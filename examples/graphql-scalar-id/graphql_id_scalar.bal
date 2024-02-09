import ballerina/graphql;

// Defines a `record` type to use as an object in the GraphQL service.
public type User readonly & record {|
    @graphql:ID int id;
    string name;
    int age;
|};

// Defines an in-memory table to store the users.
table<User> key(id) users = table [
    {id: 1, name: "Walter White", age: 50},
    {id: 2, name: "Jesse Pinkman", age: 25}
];

service /graphql on new graphql:Listener(9090) {

    resource function get user(@graphql:ID int id) returns User {
        return users.get(id);
    }
}
