import ballerina/graphql;

// The `graphql:Service` exposes a GraphQL service on provided port
service graphql:Service /graphql on new graphql:Listener(9090) {

    // A resource function inside a `graphql:Service` represents a resolver
    resource function get greet(string name) returns string {

        return "Hello, " + name;
    }
}
