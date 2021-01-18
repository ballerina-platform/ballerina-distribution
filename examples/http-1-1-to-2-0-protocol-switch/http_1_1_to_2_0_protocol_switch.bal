import ballerina/http;
import ballerina/log;

// HTTP version is set to 2.0.
http:Client http2serviceClientEP =
                        new ("http://localhost:7090", {httpVersion: "2.0"});

service /http11Service on new http:Listener(9090) {

    resource function 'default .(http:Caller caller,
                                     http:Request clientRequest) {
        // Forward the [clientRequest](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/ballerina/http/latest/http/classes/Request) to the `http2` service.
        var clientResponse = http2serviceClientEP->forward("/http2service",
                                                        clientRequest);

        http:Response response = new;
        if (clientResponse is http:Response) {
            response = clientResponse;
        } else {
            // Handle the errors that are returned when invoking the
            // [forward](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/ballerina/http/latest/http/clients/HttpClient#forward) function.
            response.statusCode = 500;
            response.setPayload(<@untainted>(<error>clientResponse).message());
        }
        // Send the response back to the caller.
        var result = caller->respond(<@untainted>response);
        if (result is error) {
           log:printError("Error occurred while sending the response",
               err = result);
        }

    }
}

// HTTP version is set to 2.0.
listener http:Listener http2serviceEP = new (7090,
    config = {httpVersion: "2.0"});

service /http2service on http2serviceEP {

    resource function 'default .(http:Caller caller,
                                    http:Request clientRequest) {
        // Construct the response message.
        http:Response response = new;
        json msg = {"response": {"message": "response from http2 service"}};
        response.setPayload(msg);

        // Send the response back to the caller (http11Service).
        var result = caller->respond(response);
        if (result is error) {
            log:printError("Error occurred while sending the response",
                err = result);
        }
    }
}
