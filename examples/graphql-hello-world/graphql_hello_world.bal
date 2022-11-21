import ballerina/graphql;

// Service attached to a GraphQL listener exposes a GraphQL service on the provided port.
service /graphql on new graphql:Listener(4000) {

    // A resource function with `get` accessor inside a `graphql:Service` represents a field in the
    // root `Query` type.
    resource function get greeting() returns string {
        return "Hello, World";
    }
}
