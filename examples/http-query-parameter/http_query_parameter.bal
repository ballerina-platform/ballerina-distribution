import ballerina/http;

service / on new http:Listener(9090) {

    // The `a`, `b` method arguments are considered as query parameters.
    resource function get sum(int a, int b) returns int {
        return  a + b;
    }
}
