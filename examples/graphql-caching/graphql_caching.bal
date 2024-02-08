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

service /graphql on new graphql:Listener(9090) {

    // A `resource` method represents a field in the root `Query` operation.
    // The `cacheConfig` in `graphql:ResourceConfig` annotation is used to 
    // configure the cache for the resource path.
    // The `enabled` field enables/disables the cache for the resource path. (default: true)
    // The `maxAge` field sets the maximum age of the cache in seconds. (default: 60)
    // The `maxSize` field indicates the maximum capacity of the cache table by entries.
    // (default: 120)
    @graphql:ResourceConfig {
        cacheConfig: {}
    }
    resource function get name(int id) returns string {
        return users.get(id).name;
    }
}
