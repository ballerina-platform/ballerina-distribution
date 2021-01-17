import ballerina/http;
import ballerina/log;
import ballerina/lang.runtime;

// Define the endpoint to the call the `mockHelloService`.
http:Client backendClientEP = new ("http://localhost:8080", {
            // Retry configuration options.
            retryConfig: {

                // Initial retry interval in milliseconds.
                intervalInMillis: 3000,

                // Number of retry attempts before giving up.
                count: 3,

                // Multiplier of the retry interval to exponentially increase
                // the retry interval.
                backOffFactor: 2.0,

                // Upper limit of the retry interval in milliseconds. If
                // `intervalInMillis` into `backOffFactor` value exceeded
                // `maxWaitIntervalInMillis` interval value,
                // `maxWaitIntervalInMillis` will be considered as the retry
                // interval.
                maxWaitIntervalInMillis: 20000

            },
            timeoutInMillis: 2000
        }
    );


service /'retry on new http:Listener(9090) {

    // Parameters include a reference to the caller and an object of the
    // request data.
    resource function 'default .(http:Caller caller, http:Request request) {

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
            response.setPayload((<@untainted error>backendResponse).message());
            var responseToCaller = caller->respond(response);
            if (responseToCaller is error) {
                log:printError("Error sending response",
                                err = responseToCaller);
            }
        }

    }
}

int counter = 0;

// This sample service is used to mock connection timeouts and service outages.
// The service outage is mocked by stopping/starting this service.
// This should run separately from the `retryDemoService` service.
service /hello on new http:Listener(8080) {

    resource function get .(http:Caller caller, http:Request req) {
        counter = counter + 1;
        if (counter % 4 != 0) {
            log:print("Request received from the client to delayed service.");
            // Delay the response by 5000 milliseconds to mimic network level delays.
            runtime:sleep(5000);

            var responseToCaller = caller->respond("Hello World!!!");
            handleRespondResult(responseToCaller);
        } else {
            log:print(
                "Request received from the client to healthy service.");
            var responseToCaller = caller->respond("Hello World!!!");
            handleRespondResult(responseToCaller);
        }
    }
}

function handleRespondResult(error? result) {
    if (result is http:ListenerError) {
        log:printError("Error sending response from mock service",
                        err = result);
    }
}
