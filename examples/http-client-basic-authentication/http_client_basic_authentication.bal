import ballerina/http;
import ballerina/io;

type Album readonly & record {|
    string title;
    string artist;
|};

public function main() returns error? {
    // Defines the HTTP client to call the Basic Auth secured APIs.
    // The client is enriched with the `Authorization: Basic <token>` header by
    // passing the `http:CredentialsConfig` for the `auth` configuration of the client.
    http:Client securedEP = check new("localhost:9090",
        auth = {
            username: "ldclakmal",
            password: "ldclakmal@123"
        },
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );
    Album[] payload = check securedEP->/albums;
    io:println(payload);
}
