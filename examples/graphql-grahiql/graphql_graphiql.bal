import ballerina/graphql;

// Enables the GraphiQL client with the provided path.
@graphql:ServiceConfig {
    graphiql: {
        enabled: true,
        path: "/graphiql"
    }
}
service /graphql on new graphql:Listener(4000) {
    resource function get greeting() returns string {
        return "Hello, World";
    }
}
