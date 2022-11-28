import ballerina/http;
import ballerina/io;

public function main() returns error? {
    http:Client backendClientEP = check new ("localhost:9090", {
        // Timeout configuration.
        timeout: 10
    });
    string payload = check backendClientEP->/albums;
    io:println(payload);
}
