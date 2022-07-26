import ballerina/graphql;

service /graphql on new graphql:Listener(4000) {

    // The input parameters of a resource function become input values of the corresponding
    // GraphQL field. In this GraphQL schema, the `greeting` field of the `Query` type has a `name`
    // input value, which accepts `string` values.
    resource function get greeting(string name) returns string {
        return string`Hello, ${name}`;
    }
}
