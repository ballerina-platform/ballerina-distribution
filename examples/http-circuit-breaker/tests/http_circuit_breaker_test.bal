import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns error? {
    http:Client httpClient = check new ("http://localhost:8080",
        // Configuration options that control the behavior of the circuit
        // breaker.
        circuitBreaker = {
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
        timeout = 2
    );
    string responseString = "Hello World!!!";
    // Send 1st GET request to the specified endpoint.
    string payload = check httpClient->/greeting;
    test:assertEquals(payload, responseString);

    // Send 2nd GET request to the specified endpoint
    payload = check httpClient->/greeting;
    test:assertEquals(payload, responseString);

    // Send 3rd GET request to the specified endpoint
    string|error result = httpClient->/greeting;
    if result is http:RemoteServerError {
        test:assertEquals(result.detail().body, "Error occurred while processing the request.");
    }

    // Send 4th GET request to the specified endpoint
    result = httpClient->/greeting;
    test:assertTrue(result is error, "Invalid type");

    // Send 5th GET request to the specified endpoint
    result = httpClient->/greeting;
    test:assertTrue(result is error, "Invalid type");

    // Send 6th GET request to the specified endpoint
    result = httpClient->/greeting;
    test:assertTrue(result is error , "Invalid type");
}

service / on new http:Listener(8080) {
    private int counter = 1;
    resource function get greeting() returns string|http:InternalServerError {
        if self.counter % 5 == 3 {
            self.counter += 1;
            return {body:"Error occurred while processing the request."};
        } else {
            self.counter += 1;
            return "Hello World!!!";
        }
    }
}
