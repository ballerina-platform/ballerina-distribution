import ballerina/graphql;

// Defines a `record` type to use as an object in the GraphQL service.
type User readonly & record {|
    int id;
    string name;
    int age;
|};

// Defines an in-memory table to store the users.
table<User> key(id) users = table [
    {id: 1, name: "Walter White", age: 50},
    {id: 2, name: "Jesse Pinkman", age: 25}
];

service /graphql on new graphql:Listener(9090) {

    // The `cacheConfig` in the `graphql:ResourceConfig` annotation is used to 
    // configure the cache for a specific field in the GraphQL service.
    // (default: {enabled: true, maxAge: 60, maxSize: 120})
    @graphql:ResourceConfig {
        cacheConfig: {}
    }
    resource function get name(int id) returns string|error {
        if users.hasKey(id) {
            return users.get(id).name;
        }
        return error(string `User with the ${id} not found`);
    }
}
