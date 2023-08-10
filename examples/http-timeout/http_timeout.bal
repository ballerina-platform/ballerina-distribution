import ballerina/http;
import ballerina/io;

type Album readonly & record {
    string title;
    string artist;
};

public function main() returns error? {
    http:Client albumClient = check new ("localhost:9090", {
        timeout: 10
    });
    Album[] payload = check albumClient->/albums;
    io:println(payload);
}
