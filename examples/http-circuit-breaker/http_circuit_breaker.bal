import ballerina/http;
import ballerina/lang.runtime;

// The circuit breaker looks for errors across a rolling time window.
// After the circuit is broken, it does not send requests to
// the backend until the `resetTime`.
http:Client backendClientEP = check new ("http://localhost:8080", {
            // Configuration options that control the behavior of the circuit
            // breaker.
            circuitBreaker: {
                // Failure calculation window. This is how long the circuit
                // breaker keeps the statistics for the operations.
                rollingWindow: {

                    // Time period in seconds for which the failure
                    // threshold is calculated.
                    timeWindow: 10,

                    // The granularity (in seconds) at which the time
                    // window slides. The `RollingWindow` is divided into
                    // buckets and slides by these increments.
                    bucketSize: 2,

                    // Minimum number of requests in the `RollingWindow` that
                    // will trip the circuit.
                    requestVolumeThreshold: 0

                },
                // The threshold for request failures.
                // When this threshold exceeds, the circuit trips. This is the
                // ratio between failures and total requests. The ratio is
                // calculated using the requests received within the given
                // rolling window.
                failureThreshold: 0.2,

                // The time period (in seconds) to wait before attempting to
                // make another request to the upstream service.
                resetTime: 10,

                // HTTP response status codes that are considered as failures
                statusCodes: [400, 404, 500]

            },
            timeout: 2
        }
    );

// Create an HTTP service bound to the endpoint (circuitBreakerEP).
service /cb on new http:Listener(9090) {

    resource function get .(http:Request request)
            returns http:Response|http:InternalServerError {
        var backendResponse = backendClientEP->forward("/hello", request);
        // If the `backendResponse` is an `http:Response`, it is sent back to
        // the client. If `backendResponse` is an `http:ClientError`, an
        // internal server error is returned to the client.
        if (backendResponse is http:Response) {
            return backendResponse;
        } else {
            return {body:backendResponse.message()};
        }

    }
}

int counter = 1;

// This sample service is used to mock connection timeouts and service outages.
// This should run separately from the `circuitBreakerDemo` service.
service /hello on new http:Listener(8080) {

    resource function get .() returns string|http:InternalServerError {
        if (counter % 5 == 0) {
            counter += 1;
            // Delay the response by 5 seconds to
            // mimic the network level delays.
            runtime:sleep(5);

            return "Hello World!!!";
        } else if (counter % 5 == 3) {
            counter += 1;
            return {body:"Error occurred while processing the request."};
        } else {
            counter += 1;
            return "Hello World!!!";
        }
    }
}
