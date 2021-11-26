import ballerina/io;

// Defines the gRPC client to call the Basic auth secured APIs.
// The client metadata is enriched with the `Authorization: Basic <token>`
// header by passing the [`grpc:CredentialsConfig`](https://docs.central.ballerina.io/ballerina/grpc/latest/records/CredentialsConfig) for the `auth` configuration
// of the client.
HelloWorldClient securedEP = check new("https://localhost:9090",
    auth = {
        username: "ldclakmal",
        password: "ldclakmal@123"
    },
    secureSocket = {
        cert: "../resource/path/to/public.crt"
    }
);

public function main() returns error? {
    string result = check securedEP->hello();
    io:println(result);
}
