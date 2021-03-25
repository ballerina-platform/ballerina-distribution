// This is the client implementation of the secured connection (HTTPS) scenario.
import ballerina/io;

public function main (string... args) returns error? {
    // The client endpoint configuration with the SSL configurations.
    HelloWorldClient ep = check new ("https://localhost:9090", {
        secureSocket: {
            cert: "../resource/path/to/public.crt"
        }
    });
    ContextString requestMessage = {content: "WSO2", headers: {}};
    // Executing the unary call.
    ContextString result = check ep->helloContext(requestMessage);
    // Print the content.
    io:println(result.content);
}
