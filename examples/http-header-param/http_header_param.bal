import ballerina/http;

service / on new http:Listener(9090) {
    // The `accept` method argument with `@http:Header` annotation is considered as the value for
    // the `Accept` HTTP header.
    resource function get header(@http:Header string accept) returns string {
        return accept;
    }
}
