import ballerina/graphql;

// This service has multiple resources with hierarchical resource paths.
// There are two resources under the `profile` path. Therefore, a type named
// `profile`, which has two fields (`quote`, and `name`) will be created when the
// GraphQL schema is generated for this service.
service graphql:Service /graphql on new graphql:Listener(9090) {

    // This resource provides a quote for the provided ID.
    resource function get profile/quote() returns string {
        return "I am the one who knocks!";
    }

    // This resource returns the name for the provided ID.
    resource function get profile/name() returns string {
        return "Walter White";
    }
}
