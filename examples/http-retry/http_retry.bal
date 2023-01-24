import ballerina/http;
import ballerina/io;

type Album readonly & record {
    string title;
    string artist;
};

public function main() returns error? {
    http:Client albumClient = check new ("localhost:9090",
        retryConfig = {
            // The initial retry interval in seconds.
            interval: 3,

            // The number of retry attempts before stopping.
            count: 3,

            // The multiplier of the retry interval exponentially increases the retry interval.
            backOffFactor: 2.0,

            // The upper limit of the retry interval is in seconds. If the `interval` into the `backOffFactor`
            // value exceeded the `maxWaitInterval` interval value, `maxWaitInterval` is considered as the retry interval.
            maxWaitInterval: 20
        }
    );
    Album[] payload = check albumClient->/albums;
    io:println(payload);
}
