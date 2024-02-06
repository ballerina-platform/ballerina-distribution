import ballerina/graphql;

service /graphql_cache on new graphql:Listener(9090) {
    private string name = "Walter White";

    // A `resource` method represents a field in the root `Query` operation.
    // The `cacheConfig` in `graphql:ResourceConfig` annotation is used to configure the cache for the resource path.
    // The `enabled` field enables/disables the cache for the resource path.
    // The `maxAge` field sets the maximum age of the cache in seconds. (default: 60)
    // The `maxSize` field indicates the maximum capacity of the cache table by entries. (default: 120)
    @graphql:ResourceConfig {
        cacheConfig: {
            enabled: true,
            maxAge: 60,
            maxSize: 120
        }
    }
    isolated resource function get name() returns int {
        return self.name;
    }

    // A `remote` method represents a field in the root `Mutation` operation. This `remote` method
    // is used to update the name and returns the value.
    isolated remote function updateName(graphql:Context context, string name) returns string|error {
        // evictCache(resourcePath: string) is used to invalidate the cache for the given resource path.
        check context.evictCache("name");
        self.name = name;
        return self.name;
    }

    // A `remote` method represents a field in the root `Mutation` operation. This `remote` method
    // is used to update the name and returns the value.
    isolated remote function updateData(graphql:Context context, string name) returns string|error {
        // invalidateAll() is used to invalidate all the caches in the service.
        check context.invalidateAll();
        self.name = name;
        return self.name;
    }
}
