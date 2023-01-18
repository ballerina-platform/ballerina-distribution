import ballerina/http;
import ballerina/io;

public function main() returns error? {
    // Define the failover client endpoint to call the backend services.
    http:FailoverClient httpClient = check new ({

        timeout: 5,
        failoverCodes: [501, 502, 503],
        interval: 5,
        // Define a set of HTTP Clients that are targeted for failover.
        targets: [
            {url: "http://nonexistentEP"},
            {url: "http://localhost:9090"}
        ]
    });
    string payload = check httpClient->/albums;
    io:println(payload);
}
