import ballerina/graphql;

// Enables the GraphiQL client with the provided path.
@graphql:ServiceConfig {
    graphiql: {
        enabled: true,
        // Path is optional, if not provided, it will be dafulted to `/graphiql`.
        path: "/testing"
    }
}
service /graphql on new graphql:Listener(9090) {
    
    resource function get greeting() returns string {
        return "Hello, World";
    }
}
