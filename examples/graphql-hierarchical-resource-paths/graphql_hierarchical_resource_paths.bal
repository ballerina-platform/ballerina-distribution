import ballerina/graphql;

// This service have multiple resources with hierarchical resource paths.
// There are two resources under the path `profile`. Therefore, a type named
// `profile` which has two fields (`quote`, and `name`) will be created when the
// GraphQL schema is generated for this service.
service graphql:Service /graphql on new graphql:Listener(9090) {

    // This resource provides a quote for the provided ID.
    resource function get profile/quote(int id) returns string {
        return "I am the one who knocks!";
    }

    // This resource returns the name for the provided ID.
    resource function get profile/name(int id) returns string {
        return string "Walter White";
    }
}
