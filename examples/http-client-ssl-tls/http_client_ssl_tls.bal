import ballerina/http;
import ballerina/io;

// An HTTP client can be configured to communicate through HTTPS as well. For HTTPS communication, 
// the client needs to be configured with the certificate file of the server.
// The [`http:ClientSecureSocket`](https://docs.central.ballerina.io/ballerina/http/latest/records/ClientSecureSocket) record provides the SSL-related configurations of the client.
http:Client securedEP = check new("https://localhost:9090",
    secureSocket = {
        cert: "../resource/path/to/public.crt"
    }
);

public function main() returns error? {
    string response = check securedEP->get("/foo/bar");
    io:println(response);
}
