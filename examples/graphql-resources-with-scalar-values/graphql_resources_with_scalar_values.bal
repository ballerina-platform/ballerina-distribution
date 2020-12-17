import ballerina/graphql;

// The `graphql:Service` exposes a GraphQL service on the provided port.
service graphql:Service /graphql on new graphql:Listener(9090) {

    // A resource function inside a `graphql:Service` represents a resolver.
    resource function query greet(string name) returns string {

        return "Hello, " + name;
    }
}
