import ballerina/io;

public function main() returns error? {
    // Defines the gRPC client to call the Basic Auth secured APIs.
    // The client metadata is enriched with the `Authorization: Basic <token>`
    // header by passing the `grpc:CredentialsConfig` for the `auth` configuration of the client.
    HelloWorldClient securedEP = check new("https://localhost:9090",
        auth = {
            username: "ldclakmal",
            password: "ldclakmal@123"
        },
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );

    string result = check securedEP->hello("WSO2");
    io:println(result);
}
