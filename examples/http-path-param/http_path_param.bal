import ballerina/http;

service /company on new http:Listener(9090) {

    // The path param is defined as a part of the resource path along with the type and it is extracted from the
    // request URI.
    resource function get employee/[string id]() returns string {
        return "Employee data";
    }
}
