import ballerina/http;
import ballerina/io;

public function main() returns error? {
    // The HTTP client's chunking behavior can be configured as `CHUNKING_AUTO`,
    // `CHUNKING_ALWAYS`, or `CHUNKING_NEVER` only available HTTP/1.1 protocol.
    // In this example, it is set to `CHUNKING_NEVER`, which means that chunking never happens irrespective of the request size.
    // When chunking is set to `CHUNKING_AUTO`, chunking is done based on the request.
    // The `http1Settings` annotation provides the chunking-related configurations.
    // For details, see https://lib.ballerina.io/ballerina/http/latest/records/ClientHttp1Settings.
    http:Client albumClient = check new ("localhost:9090",
        httpVersion = http:HTTP_1_1,
        http1Settings = {
            chunking: http:CHUNKING_NEVER
        }
    );
    string payload = check albumClient->/albums.post({title: "Sarah Vaughan and Clifford Brown", artist: "Sarah Vaughan"});
    io:println(payload);
}
