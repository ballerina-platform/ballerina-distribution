import ballerina/http;

// HTTP version is set to 2.0.
final http:Client http2serviceClientEP = check new ("http://localhost:7090");

// Since the default HTTP version is 2.0, HTTP version is set to 1.1.
service / on new http:Listener(9090, httpVersion = "1.1") {

    resource function 'default http11Service(http:Request clientRequest)
            returns json|error {
        // Forward the `clientRequest` to the `http2` service.
        // For details, see https://lib.ballerina.io/ballerina/http/latest/classes/Request.
        json clientResponse = check
            http2serviceClientEP->forward("/http2service", clientRequest);

        // Send the response back to the caller.
        return clientResponse;

    }
}

service / on new http:Listener(7090) {

    resource function 'default http2service() returns json {
        // Send the response back to the caller (http11Service).
        return { 
            "response": {
                "message":"response from http2 service"
            }
        };
    }
}
