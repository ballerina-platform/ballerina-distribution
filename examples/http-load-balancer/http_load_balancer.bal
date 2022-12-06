import ballerina/http;
import ballerina/io;

public function main() returns error? {
    // Define the load balance client endpoint to call the backend services.
    http:LoadBalanceClient httpClient = check new ({
        // Define the set of HTTP clients that need to be load balanced.
        targets: [
            {url: "http://localhost:9090"},
            {url: "http://localhost:9091"},
            {url: "http://localhost:9092"}
        ],

        timeout: 5
    });
    string payload = check httpClient->/albums;
    io:println(payload);
}
