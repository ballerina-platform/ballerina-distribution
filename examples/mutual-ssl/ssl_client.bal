import ballerina/http;
import ballerina/log;

// Create a client configuration to be passed to the client endpoint.
// Configure the `certFile`, `keyFile` including `cert` which
// is required to enable mutual SSL.
// [secureSocket](https://docs.central.ballerina.io/ballerina/http/latest/records/ClientSecureSocket) record provides the SSL related configurations.
http:ClientConfiguration clientEPConfig = {
    secureSocket: {
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
};

public function main() {
    // Create an HTTP client to interact with the created listener endpoint.
    http:Client clientEP = checkpanic new("https://localhost:9095",
                                          clientEPConfig);
    // Send a GET request to the listener and bind the payload to a string value.
    var payload = clientEP->get("/helloWorld/hello", targetType = string);

    if (payload is string) {
        // Log the retrieved text payload.
        log:printInfo(payload);

    } else {
        // If an error occurs when getting the response or binding payload, log the error.
        log:printError(payload.message());

    }
}
