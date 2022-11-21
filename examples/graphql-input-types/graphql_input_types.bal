import ballerina/graphql;

service /graphql on new graphql:Listener(4000) {

    // In the generated schema of this GraphQL service, the `greeting` field of the `Query` type has
    // an input value `name`, which is of the type `String!`.
    resource function get greeting(string name) returns string {
        return string`Hello, ${name}`;
    }
}
