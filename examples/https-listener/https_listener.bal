import ballerina/http;
import ballerina/log;

// An HTTP endpoint can be configured to communicate through HTTPS as well.
// To secure an endpoint using HTTPS, the endpoint needs to be configured with
// a certificate file and a private key file for the endpoint.
// The [secureSocket](https://ballerina.io/learn/api-docs/ballerina/#/ballerina/http/latest/http/records/ListenerSecureSocket) record provides the SSL-related listener configurations.
http:ListenerConfiguration helloWorldEPConfig = {
    secureSocket: {
        certFile: "/path/to/public.cert",
        keyFile: "/path/to/private.key"
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
