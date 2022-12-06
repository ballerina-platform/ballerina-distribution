import ballerina/http;
import ballerina/io;

type Album readonly & record {|
    string title;
    string artist;
|};

public function main() returns error? {
    // Defines the HTTP client to call the secured APIs.
    // The client is enriched with the `Authorization: Bearer <token>` header by
    // passing the `http:BearerTokenConfig` for the `auth` configuration of the client.
    http:Client albumClient = check new("localhost:9090",
        auth = {
            token: "56ede317-4511-44b4-8579-a08f094ee8c5"
        },
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );
    Album[] payload = check albumClient->/albums;
    io:println(payload);
}
