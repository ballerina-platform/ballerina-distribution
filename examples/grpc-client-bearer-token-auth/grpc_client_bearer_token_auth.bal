import ballerina/io;

public function main() returns error? {
    // Defines the gRPC client to call the APIs secured with bearer token authentication.
    HelloWorldClient securedEP = check new("https://localhost:9090",
        auth = {
            token: "56ede317-4511-44b4-8579-a08f094ee8c5"
        },
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );

    string result = check securedEP->hello("WSO2");
    io:println(result);
}
