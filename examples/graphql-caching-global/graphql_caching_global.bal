import ballerina/graphql;

// The `cacheConfig` in `graphql:ServiceConfig` annotation is used to configure the cache for the GraphQL service.
// The `enabled` field enables/disables the cache for the resource path.
// The `maxAge` field sets the maximum age of the cache in seconds. (default: 60)
// The `maxSize` field indicates the maximum capacity of the cache table by entries. (default: 120)
@graphql:ServiceConfig {
    cacheConfig: {
        enabled: true,
        maxAge: 60,
        maxSize: 120
    }
}
service /graphql on new graphql:Listener(9090) {
    private string name = "Walter White";

    isolated resource function get name() returns string {
        return self.name;
    }
}
