import ballerina/graphql;

// The `graphql:Service` exposes a GraphQL service on the provided port.
service /graphql on new graphql:Listener(4000) {

    // A resource function with `get` accessor inside a `graphql:Service` represents a resolver.
    // The resource function will be mapped to a field names `greeting` in the `Query` type.
    resource function get greeting() returns string {
        return "Hello, World";
    }
}
