import ballerina/http;

service /company on new http:Listener(9090) {

    // The path param is defined as a part of the resource path along with the type and it is extracted from the
    // request URI.
    resource function get empId/[int id]() returns json {
        return {empId: id};
    }

    resource function get empName/[string first]/[string last]() returns json {
        return {firstName: first, lastName: last};
    }
}
