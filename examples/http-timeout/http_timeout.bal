import ballerina/http;
import ballerina/io;

public function main() returns error? {
    http:Client albumClient = check new ("localhost:9090", {
        // Timeout configuration.
        timeout: 10
    });
    string payload = check albumClient->/albums;
    io:println(payload);
}
