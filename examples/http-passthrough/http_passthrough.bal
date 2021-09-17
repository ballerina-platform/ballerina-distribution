import ballerina/http;

http:Client clientEP = check new ("http://postman-echo.com");

service / on new http:Listener(9090) {

    // The passthrough resource allows all HTTP methods as the accessor is `default`.
    resource function 'default passthrough(http:Request req)
            returns http:Response|error? {
        // When [forward()](https://docs.central.ballerina.io/ballerina/http/latest/clients/Client#forward) is called on the backend client endpoint, it forwards the request that the passthrough
        // resource received to the backend. When forwarding, the request is made using the same HTTP method that was
        // used to invoke the passthrough resource. The `forward()` function returns the response from the backend if
        // there are no errors.
        http:Response response = check clientEP->forward("/get", req);
        return response;
    }
}
