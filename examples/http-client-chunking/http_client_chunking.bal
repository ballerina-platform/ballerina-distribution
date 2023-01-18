import ballerina/http;
import ballerina/io;

public function main() returns error? {
    http:Client albumClient = check new ("localhost:9090",
        httpVersion = http:HTTP_1_1,
        http1Settings = {
            chunking: http:CHUNKING_NEVER
        }
    );
    string payload = check albumClient->/albums.post({
        title: "Sarah Vaughan and Clifford Brown",
        artist: "Sarah Vaughan"
    });
    io:println(payload);
}
