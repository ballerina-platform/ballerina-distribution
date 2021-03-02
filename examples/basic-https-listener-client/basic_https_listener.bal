import ballerina/http;
import ballerina/log;

// `helloWorldEP` listener endpoint is configured to communicate through HTTPS.
// It is configured to listen on port 9095. As this is an HTTPS Listener,
// it is required to configure certificate file and private key file.
http:ListenerConfiguration helloWorldEPConfig = {
    secureSocket: {
        certFile: "../resource/path/to/public.crt",
        keyFile: "../resource/path/to/private.key"
    }
};

listener http:Listener helloWorldEP = new (9095, helloWorldEPConfig);

service /helloWorld on helloWorldEP {

    resource function get hello(http:Caller caller, http:Request req) {
        // Send the response back to the `caller`.
        var result = caller->respond("Hello World!");
        if (result is error) {
            log:printError("Failed to respond", err = result);
        }
    }
}
