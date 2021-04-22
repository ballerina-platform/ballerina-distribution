import ballerina/http;
import ballerina/log;

http:Client clientEP = check new ("http://localhost:9092/hello");

service /passthrough on new http:Listener(9090) {

    // The passthrough resource allows all HTTP methods since the resource configuration does not explicitly specify
    // which HTTP methods are allowed.
    resource function 'default .(http:Request req)
            returns http:Response|http:InternalServerError {
        // When [forward()](https://docs.central.ballerina.io/ballerina/http/latest/clients/Client#forward) is called on the backend client endpoint, it forwards the request that the passthrough
        // resource received to the backend. When forwarding, the request is made using the same HTTP method that was
        // used to invoke the passthrough resource. The `forward()` function returns the response from the backend if
        // there are no errors.
        var clientResponse = clientEP->forward("/", req);

        // `forward()` can return an HTTP response or an error.
        if (clientResponse is http:Response) {
            // If the request was successful, an HTTP response is returned.
            return clientResponse;

        } else {
            // If there was an error, the 500 error response is sent back to the client.
            return {body: clientResponse.message()};

        }
    }
}

// Sample hello world service.
service /hello on new http:Listener(9092) {

    // The `helloResource` accepts any HTTP methods as the accessor is defined as `'default`.
    resource function 'default .(http:Caller caller) {
        // [Send the response](https://docs.central.ballerina.io/ballerina/http/latest/clients/Caller#respond) back to the caller.
        var result = caller->respond("Hello World!");

        if (result is error) {
            log:printError("Error sending response", 'error = result);
        }
    }
}
