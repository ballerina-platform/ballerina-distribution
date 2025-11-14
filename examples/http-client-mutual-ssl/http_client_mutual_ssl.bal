import ballerina/http;
import ballerina/io;

type Album readonly & record {
    string title;
    string artist;
};

public function main() returns error? {
    // The HTTP client can be configured to initiate new connections that are secured via mutual SSL.
    http:Client albumClient = check new ("localhost:9090",
        secureSocket = {
            key: {
                certFile: "../resource/path/to/client-public.crt",
                keyFile: "../resource/path/to/client-private.key"
            },
            cert: "../resource/path/to/server-public.crt"
        }
    );
    Album[] payload = check albumClient->/albums;
    io:println(payload);
}
