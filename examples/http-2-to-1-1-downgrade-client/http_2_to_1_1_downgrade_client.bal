import ballerina/http;
import ballerina/io;

type Album readonly & record {
    string title;
    string artist;
};

public function main() returns error? {
    // Since the default HTTP version is 2.0, HTTP version is set to 1.1.
    http:Client albumClient = check new ("localhost:9090", httpVersion = http:HTTP_1_1);
    Album[] albums = check albumClient->/albums;
    io:println("GET request:" + albums.toJsonString());
}
