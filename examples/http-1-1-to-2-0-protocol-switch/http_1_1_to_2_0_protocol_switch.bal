import ballerina/http;

// HTTP version is set to 2.0.
final http:Client http2serviceClientEP = check new ("http://localhost:7090");

// Since the default HTTP version is 2.0, HTTP version is set to 1.1.
service / on new http:Listener(9090, httpVersion = http:HTTP_1_1) {

    resource function 'default http11service(http:Request clientRequest) returns string|error {
        // Forward the `clientRequest` to the `http2` service.
        // For details, see https://lib.ballerina.io/ballerina/http/latest/classes/Request.
        string clientResponse = check http2serviceClientEP->forward("/http2service", clientRequest);

        // Send the response back to the caller.
        return clientResponse;

    }
}

service / on new http:Listener(7090) {

    resource function 'default http2service() returns string {
        // Send the response back to the caller (http11Service).
        return "message : response from http2 service";
    }
}
