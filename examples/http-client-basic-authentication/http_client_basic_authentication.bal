import ballerina/http;
import ballerina/io;

public function main() returns error? {
    // Defines the HTTP client to call the Basic Auth secured APIs.
    // The client is enriched with the `Authorization: Basic <token>` header by
    // passing the `http:CredentialsConfig` for the `auth` configuration of the client.
    http:Client securedEP = check new("https://localhost:9090",
        auth = {
            username: "ldclakmal",
            password: "ldclakmal@123"
        },
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );
    string response = check securedEP->/foo/bar;
    io:println(response);
}
