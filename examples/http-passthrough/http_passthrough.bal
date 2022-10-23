import ballerina/http;

http:Client clientEP = check new ("postman-echo.com");

service / on new http:Listener(9090) {

    // The passthrough resource allows all HTTP methods as the accessor is `default`. The rest parameter in the
    // resource path, allows any request URI to get dispatched
    resource function 'default [string... path](http:Request req) returns json|error {
        // When forward()` is called on the backend client endpoint, it forwards the request that the passthrough
        // resource received to the backend. When forwarding, the request is made using the same HTTP method that was
        // used to invoke the passthrough resource. The `forward()` function returns the response from the backend if
        // there are no errors.
        // For details, see https://lib.ballerina.io/ballerina/http/latest/clients/Client#forward.
        json payload = check clientEP->forward("/get", req);
        return payload;
    }
}
