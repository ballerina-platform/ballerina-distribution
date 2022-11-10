import ballerina/http;

map<string> data = { "23": "Mike Wheeler", "38" : "Dustin Henderson"};

service /company on new http:Listener(9090) {

    // The path param is defined as a part of the resource path along with the type and it is extracted from the
    // request URI.
    resource function get employees/[string id]() returns string {
        string? name = data[id];
        return name is string ? string `Employee is ${name}` : "Invalid employee id";
    }
}
