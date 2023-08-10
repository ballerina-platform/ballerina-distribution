import ballerina/http;
import ballerina/io;

type Album readonly & record {
    string title;
    string artist;
};

public function main() returns error? {
    http:Client albumClient = check new ("localhost:9090",
        httpVersion = http:HTTP_1_1,
        http1Settings = {
            chunking: http:CHUNKING_NEVER
        }
    );
    Album payload = check albumClient->/albums.post({
        title: "Sarah Vaughan and Clifford Brown",
        artist: "Sarah Vaughan"
    });
    io:println(payload);
}
