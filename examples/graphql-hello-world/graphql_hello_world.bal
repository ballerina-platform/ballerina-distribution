import ballerina/graphql;

// The `graphql:Service` exposes a GraphQL service on the provided port.
service /graphql on new graphql:Listener(4000) {

    // A resource function inside a `graphql:Service` represents a resolver.
    // This resource can be queried using the `{ greeting }`.
    resource function get greeting() returns string {

        return "Hello, World";
    }
}
