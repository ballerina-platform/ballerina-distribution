import ballerina/http;

// An HTTP endpoint can be configured to communicate through HTTPS as well.
// To secure an endpoint using HTTPS, the endpoint needs to be configured with
// a certificate file and a private key file for the endpoint.
// The [secureSocket](https://docs.central.ballerina.io/ballerina/http/latest/records/ListenerSecureSocket) record provides the SSL-related listener configurations.
http:ListenerConfiguration helloWorldEPConfig = {
    secureSocket: {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        }
    }
};

// Create a listener endpoint.
listener http:Listener helloWorldEP = new (9095, helloWorldEPConfig);

service /hello on helloWorldEP {

    resource function get .() returns string {
        // Send the response with a string payload back to the caller.
        return "Hello World!";
    }
}
