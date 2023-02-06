import ballerina/http;
import ballerina/io;

type Album readonly & record {|
    string title;
    string artist;
|};

public function main() returns error? {
    // The `followRedirects` record provides configurations associated with HTTP redirects.
    http:Client albumClient = check new ("localhost:9092",
        followRedirects = {
            enabled: true,
            maxCount: 5
        }
    );
    Album[] payload = check albumClient->/redirect;
    io:println(string `Response received: ${payload.toJsonString()}`);
}
