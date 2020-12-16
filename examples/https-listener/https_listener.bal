import ballerina/config;
import ballerina/http;
import ballerina/log;

// An HTTP endpoint can be configured to communicate through HTTPS as well.
// To secure an endpoint using HTTPS, the endpoint needs to be configured with
// a keystore and its `password` for the endpoint.
// The [secureSocket](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/http/records/ListenerSecureSocket) record provides the SSL-related listener configurations.
http:ListenerConfiguration helloWorldEPConfig = {
    secureSocket: {
        keyStore: {
            path: config:getAsString("b7a.home") +
                  "/bre/security/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
};

// Create a listener endpoint.
listener http:Listener helloWorldEP = new (9095, helloWorldEPConfig);

service /hello on helloWorldEP {

    resource function get .(http:Caller caller, http:Request req) {
        // Send the response back to the caller.
        var result = caller->respond("Hello World!");
        if (result is error) {
            log:printError("Error in responding ", err = result);
        }
    }
}
