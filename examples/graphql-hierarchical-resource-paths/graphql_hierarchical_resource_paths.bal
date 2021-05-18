import ballerina/graphql;

// This service has multiple resources with hierarchical resource paths.
// The root operation has a field named `profile`, as it is the first segment
// of the hierarchical path in this service. The type of this field will also
// be `profile`. (For hierarchical paths, the field name and the type name will
// be the same). The `profile` type has two fields, `quote`, and `name`. The
// type of the `quote` field is `String`, and the type of the `name` field is
// `name`. The type `name` has two fields, `first`, and the `last`. Both of the
// fields are of type `String`.
service graphql:Service /graphql on new graphql:Listener(9090) {

    // This resource represents the field `quote` under the `profile` object.
    resource function get profile/quote() returns string {
        return "I am the one who knocks!";
    }

    // This resource represents the field `first` under the object type `name`.
    // The `name` field in the `profile` object is of type `name`.
    resource function get profile/name/first() returns string {
        return "Walter";
    }

    // This resource represents the field `last` under the object type `name`.
    // The `name` field in the `profile` object is of type `name`.
    resource function get profile/name/last() returns string {
        return "White";
    }
}
