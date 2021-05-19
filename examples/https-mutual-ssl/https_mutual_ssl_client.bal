import ballerina/http;
import ballerina/log;

// An HTTP client can be configured to initiate new connections that are
// secured via mutual SSL.
// The [http:ClientSecureSocket](https://docs.central.ballerina.io/ballerina/http/latest/records/ClientSecureSocket) record provides the SSL-related configurations.
http:Client securedEP = check new("https://localhost:9090",
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        },
        mutualSsl: {
            cert: "../resource/path/to/public.crt"
        },
        protocol: {
            name: http:TLS
        },
        ciphers: ["TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA"]
    }
);

public function main() returns error? {
    http:Response response = check securedEP->get("/foo/bar");
    log:printInfo(response.statusCode.toString());
}
