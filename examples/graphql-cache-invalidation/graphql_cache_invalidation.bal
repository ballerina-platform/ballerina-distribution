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

    @graphql:ResourceConfig {
        cacheConfig: {}
    }
    resource function get name(int id) returns string|error {
        if users.hasKey(id) {
            return users.get(id).name;
        }
        return error("User not found");
    }

    @graphql:ResourceConfig {
        cacheConfig: {}
    }
    resource function get user(int id) returns User|error {
        if users.hasKey(id) {
            return users.get(id);
        }
        return error("User not found");
    }

    // Updates the name of a user.
    remote function updateName(graphql:Context context, int id, string name) returns string|error {
        // `invalidate()` is used to invalidate the cache for the given field.
        check context.invalidate("name");
        User user = {id: id, name: name, age: users.remove(id).age};
        users.add(user);
        return user.name;
    }

    // Deletes a user.
    remote function deleteUser(graphql:Context context, int id) returns User|error {
        // `invalidateAll()` is used to invalidate all the caches in the service.
        check context.invalidateAll();
        User user = users.remove(id);
        return user;
    }
}
