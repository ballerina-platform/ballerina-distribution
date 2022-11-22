import ballerina/http;
import ballerina/io;

public function main() returns error? {
    // The `followRedirects` record provides configurations associated with HTTP redirects.
    http:Client httpClient = check new ("localhost:9090",
        followRedirects = {
            enabled: true,
            maxCount: 5
        }
    );
    string payload = check httpClient->/redirect;
    io:println(string `Response received: ${payload}`);
}
