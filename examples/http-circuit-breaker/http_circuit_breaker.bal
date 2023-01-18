import ballerina/http;
import ballerina/io;

public function main() returns error? {
    http:Client httpClient = check new ("localhost:9090",
        circuitBreaker = {
            // The failure calculation window measures how long the circuit breaker keeps the
            // statistics for the operations.
            rollingWindow: {

                // The period is in seconds for which the failure threshold is calculated.
                timeWindow: 10,

                // The granularity (in seconds) at which the time window slides.
                // The rolling window is divided into buckets and slides by these increments.
                bucketSize: 2,

                // The minimum number of requests in the rolling window that trips the circuit.
                requestVolumeThreshold: 0

            },
            // The threshold for request failures. When this threshold exceeds, the circuit trips.
            // This is the ratio between failures and total requests. The ratio is calculated using
            // the requests received within the given rolling window.
            failureThreshold: 0.2,

            // The period (in seconds) to wait before attempting to make another request to the upstream service.
            resetTime: 10,

            // HTTP response status codes that are considered as failures
            statusCodes: [400, 404, 500]

        }
    );
    string payload = check httpClient->/albums;
    io:println(payload);
}
