// This is the client implementation of the secured connection (HTTPS) scenario.
import ballerina/io;

// Create a gRPC client to interact securely with the remote server.
HelloWorldClient ep = check new ("https://localhost:9090", {
    secureSocket: {
        cert: "../resource/path/to/public.crt"
    }
});

public function main () returns error? {
    // Execute a simple remote call.
    string result = check ep->hello("WSO2");
    // Print the received result.
    io:println(result);
}
