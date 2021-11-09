import ballerina/io;

// Defines the gRPC client to call the secured APIs.
// The client metadata is enriched with the `Authorization: Bearer <token>`
// header by passing the [`grpc:BearerTokenConfig`](https://docs.central.ballerina.io/ballerina/grpc/latest/records/BearerTokenConfig) for the `auth` configuration
// of the client.
HelloWorldClient securedEP = check new("https://localhost:9090",
    auth = {
        token: "56ede317-4511-44b4-8579-a08f094ee8c5"
    },
    secureSocket = {
        cert: "../resource/path/to/public.crt"
    }
);

public function main() returns error? {
    string result = check securedEP->hello();
    io:println(result);
}
