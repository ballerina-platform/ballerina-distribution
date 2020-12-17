import ballerina/http;
import ballerina/log;
import ballerina/runtime;

http:Client backendClientEP = new ("http://localhost:8080", {
        // Timeout configuration.
        timeoutInMillis: 10000

    });

// Create an HTTP service bound to the listener endpoint.
service /timeout on new http:Listener(9090) {

    resource function get .(http:Caller caller, http:Request request) {
        var backendResponse = backendClientEP->forward("/hello", request);

        // If `backendResponse` is an `http:Response`, it is sent back to the
        // client. If `backendResponse` is an `http:ClientError`, an internal
        // server error is returned to the client.
        if (backendResponse is http:Response) {
            var responseToCaller = caller->respond(<@untainted>backendResponse);
            if (responseToCaller is error) {
                log:printError("Error sending response",
                                err = responseToCaller);
            }
        } else {
            http:Response response = new;
            response.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
            string errorMessage = (<error>backendResponse).message();
            string expectedMessage = "Idle timeout triggered before " +
                "initiating inbound response";
            if (errorMessage == expectedMessage) {
                response.setPayload(
                    "Request timed out. Please try again in sometime."
                );
            } else {
                response.setPayload(<@untainted>errorMessage);
            }
            var responseToCaller = caller->respond(response);
            if (responseToCaller is error) {
                log:printError("Error sending response",
                                err = responseToCaller);
            }
        }

    }
}

// This sample service is used to mock connection timeouts.
service /hello on new http:Listener(8080) {

    resource function get .(http:Caller caller, http:Request req) {
        // Delay the response by 15000 milliseconds to mimic the network level
        // delays.
        runtime:sleep(15000);

        var result = caller->respond("Hello World!!!");
        if (result is error) {
            log:printError("Error sending response from mock service",
                            err = result);
        }
    }
}
