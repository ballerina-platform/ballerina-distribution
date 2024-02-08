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
    // The `cacheConfig` in the `graphql:ResourceConfig` annotation is used to 
    // configure the cache for a specific field in the GraphQL service.
    // The `enabled` field enables/disables the cache for the field.
    // The `maxAge` field sets the maximum age of the cache in seconds. (default: 60)
    // The `maxSize` field indicates the maximum capacity of the cache table 
    // by entries. (default: 120)
    @graphql:ResourceConfig {
        cacheConfig: {}
    }
    resource function get name(int id) returns string {
        return users.get(id).name;
    }

    // A `remote` method represents a field in the root `Mutation` operation. This `remote` method
    // is used to update the name and returns the value.
    remote function updateName(graphql:Context context, int id, string name) returns string|error {
        // invalidate() is used to invalidate the cache for the given resource path.
        check context.invalidate("name");
        User user = {id: id, name: name, age: users.remove(id).age};
        users.add(user);
        return user.name;
    }

    // A `remote` method represents a field in the root `Mutation` operation. This `remote` method
    // is used to update the name and returns the value.
    remote function updateData(graphql:Context context, int id, string name) returns string|error {
        // invalidateAll() is used to invalidate all the caches in the service.
        check context.invalidateAll();
        User user = {id: id, name: name, age: users.remove(id).age};
        users.add(user);
        return user.name;
    }
}
