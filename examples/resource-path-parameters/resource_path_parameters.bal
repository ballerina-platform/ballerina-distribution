import ballerina/http;

service /demo on new http:Listener(8080) {
    // Here is how you can make path segments as parameters.
    resource function get greeting/hello/[string name]() returns string {

        return "Hello, " + name;
    }
}
