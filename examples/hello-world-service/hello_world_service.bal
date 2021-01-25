import ballerina/http;

// By default, Ballerina exposes an HTTP service via HTTP/1.1.
service /hello on new http:Listener(9090) {

    // Resource method is invoked by GET request for
    // `/hello/sayHello` path. The returned string value
    // is eventually becomes the payload of the http:Response.
    resource function get sayHello() returns string {
        return "Hello, World!";
    }
}
