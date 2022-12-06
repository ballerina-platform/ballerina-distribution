import ballerina/http;
import ballerina/io;

public function main() returns error? {
    http:Client httpClient = check new ("localhost:9090",
        // Retry configuration options.
        retryConfig = {

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
        });
    string payload = check httpClient->/albums;
    io:println(payload);
}
