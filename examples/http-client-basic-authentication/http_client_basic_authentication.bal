import ballerina/http;
import ballerina/io;

type Album readonly & record {|
    string title;
    string artist;
|};

public function main() returns error? {
    // Defines the HTTP client to call the APIs secured with basic authentication.
    http:Client albumClient = check new("localhost:9090",
        auth = {
            username: "ldclakmal",
            password: "ldclakmal@123"
        },
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );
    Album[] payload = check albumClient->/albums;
    io:println(payload);
}
