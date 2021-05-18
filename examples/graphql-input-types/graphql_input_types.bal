import ballerina/graphql;

service /graphql on new graphql:Listener(4000) {

    // The input parameters in a resource function becomes input values of the
    // corresponding GraphQL field. In this GraphQL schema, the field
    // `greeting` of type `Query` has an input value, `name`, which accepts
    // `string` values.
    isolated resource function get greeting(string name) returns string {

        return string`Hello, ${name}`;
    }
}
