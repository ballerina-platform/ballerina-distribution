import ballerina/http;
import ballerina/io;

// An HTTP client can be configured to initiate new connections that are
// secured via mutual SSL.
// The [`http:ClientSecureSocket`](https://docs.central.ballerina.io/ballerina/http/latest/records/ClientSecureSocket) record provides the SSL-related configurations.
http:Client securedEP = check new("https://localhost:9090",
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        },
        cert: "../resource/path/to/public.crt",
        protocol: {
            name: http:TLS
        },
        ciphers: ["TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA"]

    }
);

public function main() returns error? {
    string response = check securedEP->get("/foo/bar");
    io:println(response);
}
