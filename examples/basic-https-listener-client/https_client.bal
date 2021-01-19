import ballerina/config;
import ballerina/http;
import ballerina/log;

// This is a client endpoint configured to connect to the HTTPS service.
// As this is a 1-way SSL connection, the client needs to provide
// `trustStore` file `path` and its `password`.
// [secureSocket](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/ballerina/http/latest/http/records/ClientSecureSocket) record provides the SSL related configurations.
http:ClientConfiguration clientEPConfig = {
    secureSocket: {
        trustStore: {
            path: config:getAsString("b7a.home") +
                  "/bre/security/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
};

public function main() {
    // Create an HTTP client to interact with the created listener endpoint.
    http:Client clientEP = new("https://localhost:9095", clientEPConfig);
    // Sends an outbound request and bind the payload to a string value.
    var payload = clientEP->get("/helloWorld/hello", targetType = string);
    if (payload is string) {
        // Log the retrieved text payload.
        log:print(payload);
    } else {
        // If an error occurs when getting the response or binding payload, log the error.
        log:printError((<error>payload).message());
    }
}
