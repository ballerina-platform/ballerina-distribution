import ballerina/http;
import ballerina/io;

type Album readonly & record {|
    string title;
    string artist;
|};

public function main() returns error? {
    // Enable HTTP/2 prior knowledge.
    http:Client httpClient = check new ("localhost:9090", http2Settings = { http2PriorKnowledge: true });
    Album[] albums = check httpClient->/albums;
    io:println("GET request:" + albums.toJsonString());
}
