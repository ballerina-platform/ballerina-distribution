import ballerina/graphql;

// Defines a `record` type to use as an object in the GraphQL service.
type User readonly & record {|
    int id;
    string name;
    int age;
|};

// Defines an in-memory table to store the profiles.
table<User> key(id) users = table [
    {id: 1, name: "Walter White", age: 50},
    {id: 2, name: "Jesse Pinkman", age: 25}
];

// The `cacheConfig` in the `graphql:ServiceConfig` annotation is used to 
// configure the cache for the GraphQL service.
// (default: {enabled: true, maxAge: 60, maxSize: 120})
@graphql:ServiceConfig {
    cacheConfig: {}
}
service /graphql on new graphql:Listener(9090) {

    resource function get name(int id) returns string {
        return users.get(id).name;
    }

    // The `enabled` field enables/disables the cache for the field. (default: true)
    // The `maxAge` field sets the maximum age of the cache in seconds. (default: 60)
    // The `maxSize` field indicates the maximum capacity of the cache table by entries. 
    // (default: 120)
    @graphql:ResourceConfig {
        cacheConfig: {
            enabled: false,
            maxAge: 600,
            maxSize: 100
        }
    }
    resource function get age(int id) returns int {
        return users.get(id).age;
    }
}
