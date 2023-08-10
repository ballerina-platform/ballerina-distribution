import ballerina/http;
import ballerina/io;

public type Album readonly & record {|
    string title;
    string artist;
|};

public client class Client {
    // The HTTP client to access the HTTP services.
    private final http:Client httpClient;

    function init(string url) returns error? {
        self.httpClient = check new (url);
    }

    resource function get [string path]() returns Album[]|error {
        return check self.httpClient->/[path];
    }

    resource function post [string path](Album album) returns error? {
        Album updatedAlbum = check self.httpClient->/[path].post(album);
        io:println("\nPOST request: ", updatedAlbum);
    }
}

public function main() returns error? {
    Client albumClient = check new ("localhost:9090");

    // `->` is used to access the resource/remote functions in the client class.
    // Sends a `GET` request to the `/albums` resource.
    Album[] albums = check albumClient->/["albums"];
    io:println(albums);

    Album newAlbum = {"title": "Sarah Vaughan and Clifford Brown", "artist": "Sarah Vaughan"};

    // Sends a `POST` request to the `/albums` resource.
    check albumClient->/["albums"].post(newAlbum);
}
