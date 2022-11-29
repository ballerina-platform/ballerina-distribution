import ballerina/http;
import ballerina/io;

type Album readonly & record {|
    string title;
    string artist;
|};

public function main() returns error? {
    // An HTTP client can be configured to initiate new connections that are secured via mutual SSL.
    // The `http:ClientSecureSocket` record provides the SSL-related configurations.
    http:Client securedEP = check new("localhost:9090",
        secureSocket = {
            key: {
                certFile: "../resource/path/to/public.crt",
                keyFile: "../resource/path/to/private.key"
            },
            cert: "../resource/path/to/public.crt"
        }
    );
    Album[] payload = check securedEP->/albums;
    io:println(payload);
}
