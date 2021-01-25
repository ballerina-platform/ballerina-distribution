import ballerina/http;

// By default, Ballerina exposes an HTTP service via HTTP/1.1.
service /hello on new http:Listener(9090) {

    // The resource method is invoked by the GET request for the
    // `/hello/sayHello` path. The returned string value
    // eventually becomes the payload of the `http:Response`.
    resource function get sayHello() returns string {
        return "Hello, World!";
    }
}
