import ballerina/http;

// The `absolute resource path` represents the absolute path to the service. When bound to a listener
// endpoint, the service will be accessible at the specified path. If the path is omitted, then it defaults to `/`.
// A string literal also can represent the absolute path. E.g., `"/info"`.
service /info on new http:Listener(9090) {

    // The `resource method name` (`get`) confines the resource to the specified HTTP methods. In this
    // instance, only `GET` requests are allowed. The `default` accessor can be used to match with all methods
    // including standard HTTP methods and custom methods.
    // The `resource path` associates the relative path to the service object's path. E.g., `student`.
    resource function get student() returns string {
        return "Student data";
    }
}
