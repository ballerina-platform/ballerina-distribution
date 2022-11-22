import ballerina/http;

@http:ServiceConfig {
    chunking: http:CHUNKING_ALWAYS
}
service / on new http:Listener(9090, httpVersion = http:HTTP_1_1) {
    resource function get greeting() returns string {
        return "Hello world!";
    }
}
