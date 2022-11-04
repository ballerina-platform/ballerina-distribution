import ballerina/http;

service /info on new http:Listener(9090) {
    // The `trace-id` argument with `@http:Header` annotation takes the value of the `Trace-Id` request header.
    resource function get student(@http:Header string trace\-id) returns string {
        return trace\-id;
    }
}
