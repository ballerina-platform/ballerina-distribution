import ballerina/graphql;

// This service has multiple resources with hierarchical resource paths. Since all the resource
// paths starts with `profile`, the root `Query` operation will have a single field named `profile`.
// The type of this field is `profile!`. (For hierarchical paths, the field name and the
// type name will be the same). The `profile` type has two fields: `quote` and `name`. The type of
// the `quote` field is `String!` and the type of the `name` field is `name!`. The `name` type has
// two fields: `first` and the `last`. Both of the fields are of type `String!`.
service /graphql on new graphql:Listener(9090) {

    // This resource method represents the `quote` field under the `profile` object.
    resource function get profile/quote() returns string {
        return "I am the one who knocks!";
    }

    // This resource method represents the `first` field under the `name` object type. The `name`
    // field in the `profile` object is of type `name!`.
    resource function get profile/name/first() returns string {
        return "Walter";
    }

    // This resource method represents the `last` field under the `name` object type. The `name`
    // field in the `profile` object is of type `name!`.
    resource function get profile/name/last() returns string {
        return "White";
    }
}
