import ballerina/graphql;

service /graphql on new graphql:Listener(4000) {

    // The input parameters in a resource function becomes input values of the
    // corresponding GraphQL field. In this GraphQL schema, the 
    // `greeting` field of `Query` type  has a `name`  input value, which accepts
    // `string` values.
    resource function get greeting(string name) returns string {

        return string`Hello, ${name}`;
    }
}
