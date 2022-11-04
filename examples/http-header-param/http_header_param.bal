import ballerina/http;

service /info on new http:Listener(9090) {
    // The `accept` method argument with `@http:Header` annotation is considered as the value for
    // the `Accept` HTTP header.
    resource function get student(@http:Header string trace\-id) returns string {
        return trace\-id;
    }
}
