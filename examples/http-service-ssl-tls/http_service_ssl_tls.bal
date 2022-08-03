import ballerina/http;

// An HTTP listener can be configured to communicate via HTTPS. To secure the listener, listener 
// needs to be configured with certificate file and a private key file.
// The [`http:ListenerSecureSocket`](https://docs.central.ballerina.io/ballerina/http/latest/records/ListenerSecureSocket) record contains the configurations related to listener SSL. 
listener http:Listener securedEP = new(9090,
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        }
    }
);

service /foo on securedEP {
    resource function get bar() returns string {
        return "Hello, World!";
    }
}
