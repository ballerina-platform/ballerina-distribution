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
    resource function get user(int id) returns User|error {
        if users.hasKey(id) {
            return users.get(id);
        }
        return error(string `User with the ${id} not found`);
    }

    @graphql:ResourceConfig {
        cacheConfig: {}
    }
    resource function get users() returns User[] {
        return users.toArray();
    }

    // Updates a user.
    remote function updateUser(graphql:Context context, int id, string name,
                               int age) returns User|error {
        // `invalidate()` is used to invalidate the cache for the given field.
        check context.invalidate("user");
        if users.hasKey(id) {
            _ = users.remove(id);
            User user = {id: id, name: name, age: age};
            users.add(user);
            return user;
        }
        return error(string `User with the ${id} not found`);
    }

    // Deletes a user.
    remote function deleteUser(graphql:Context context, int id) returns User|error {
        // `invalidateAll()` is used to invalidate all the caches in the service.
        check context.invalidateAll();
        if users.hasKey(id) {
            User user = users.remove(id);
            return user;
        }
        return error(string `User with the ${id} not found`);
    }
}
