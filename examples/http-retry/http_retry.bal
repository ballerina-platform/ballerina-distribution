import ballerina/http;
import ballerina/log;
import ballerina/lang.runtime;

// Define the endpoint to the call the `mockHelloService`.
http:Client backendClientEP = check new ("http://localhost:8080", {
            // Retry configuration options.
            retryConfig: {

                // Initial retry interval in seconds.
                interval: 3,

                // Number of retry attempts before giving up.
                count: 3,

                // Multiplier of the retry interval to exponentially increase
                // the retry interval.
                backOffFactor: 2.0,

                // Upper limit of the retry interval in seconds. If
                // `interval` into `backOffFactor` value exceeded
                // `maxWaitInterval` interval value,
                // `maxWaitInterval` will be considered as the retry
                // interval.
                maxWaitInterval: 20

            },
            timeout: 2
        }
    );


service /'retry on new http:Listener(9090) {

    // Parameters include a reference to the caller and an object of the
    // request data.
    resource function 'default .() returns string|http:InternalServerError {

        string|error backendResponse = backendClientEP->get("/hello");

        // If `backendResponse` is a `string`, it is sent back to the
        // client. If `backendResponse` is an `http:ClientError`, an internal
        // server error is returned to the client.
        if (backendResponse is string) {
            return backendResponse;
        } else {
            return { body: backendResponse.message()};
        }

    }
}

int counter = 0;

// This sample service is used to mock connection timeouts and service outages.
// The service outage is mocked by stopping/starting this service.
// This should run separately from the `retryDemoService` service.
service /hello on new http:Listener(8080) {

    resource function get .() returns string {
        counter += 1;
        // Delay the response by 5 seconds to mimic network level delays.
        if (counter % 4 != 0) {
            log:printInfo(
                "Request received from the client to delayed service.");
            runtime:sleep(5);

            return "Hello World!!!";
        } else {
            log:printInfo(
                "Request received from the client to healthy service.");
            return "Hello World!!!";
        }
    }
}
