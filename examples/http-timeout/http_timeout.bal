import ballerina/http;
import ballerina/io;

public function main() returns error? {
    http:Client backendClientEP = check new ("localhost:8080", {
        // Timeout configuration.
        timeout: 10
    });
    string payload = check backendClientEP->/greeting;
    io:println(payload);
}
