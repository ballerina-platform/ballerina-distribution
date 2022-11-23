import ballerina/http;
import ballerina/io;

public function main() returns error? {
    // An HTTP client can be configured to communicate through HTTPS as well.
    // To secure a client using HTTPS, the client needs to be configured with
    // a certificate file of the listener. The `http:ClientSecureSocket` record
    // provides the SSL-related configurations of the client.
    http:Client securedEP = check new("https://localhost:9090",
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );
    string response = check securedEP->/foo/bar;
    io:println(response);
}
