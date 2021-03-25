import ballerina/http;

// `helloWorldEP` listener endpoint is configured to communicate through HTTPS.
// It is configured to listen on port 9095. As this is an HTTPS Listener,
// it is required to configure certificate file and private key file.
http:ListenerConfiguration helloWorldEPConfig = {
    secureSocket: {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        }
    }
};

listener http:Listener helloWorldEP = new (9095, helloWorldEPConfig);

service /helloWorld on helloWorldEP {

    resource function get hello() returns string {
        // Send the response with the string payload back to the `caller`.
        return "Hello World!";
    }
}
