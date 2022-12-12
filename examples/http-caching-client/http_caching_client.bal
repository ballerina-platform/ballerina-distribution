import ballerina/http;
import ballerina/io;

type Album readonly & record {|
    string title;
    string artist;
|};

public function main() returns error? {
    // In this example, the `isShared` field of the `cacheConfig` is set
    // to true, as the cache will be a public cache in this particular scenario.
    http:Client albumClient = check new ("localhost:9090",
        cache = {
            enabled: false,
            isShared: true
        }
    );

    Album album = check albumClient->/albums/Jeru;
    io:println("Received album: " + album.toJsonString());
}
