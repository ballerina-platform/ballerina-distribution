import ballerina/http;

service / on new http:Listener(9090) {

    // The `page` method argument is considered as query parameters.
    resource function get info(int page) returns string {
        return  string `Info on page ${page}`;
    }
}
