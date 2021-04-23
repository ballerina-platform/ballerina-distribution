import ballerina/http;

// HTTP version is set to 2.0.
http:Client http2serviceClientEP =
        checkpanic new ("http://localhost:7090", {httpVersion: "2.0"});

service /http11Service on new http:Listener(9090) {

    resource function 'default .(http:Request clientRequest)
            returns http:Response {
        // Forward the [clientRequest](https://docs.central.ballerina.io/ballerina/http/latest/classes/Request) to the `http2` service.
        var clientResponse = http2serviceClientEP->forward("/http2service",
                                                        clientRequest);

        http:Response response = new;
        if (clientResponse is http:Response) {
            response = clientResponse;
        } else {
            // Handle the errors that are returned when invoking the
            // [forward](https://docs.central.ballerina.io/ballerina/http/latest/clients/HttpClient#forward) function.
            response.statusCode = 500;
            response.setPayload(<@untainted>clientResponse.message());

        }
        // Send the response back to the caller.
        return response;

    }
}

// HTTP version is set to 2.0.
listener http:Listener http2serviceEP = new (7090,
    config = {httpVersion: "2.0"});

service /http2service on http2serviceEP {

    resource function 'default .() returns json {
        // Construct the response payload.
        json response = {"response":{"message":"response from http2 service"}};

        // Send the response back to the caller (http11Service).
        return response;
    }
}
