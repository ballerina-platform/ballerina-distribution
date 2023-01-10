import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

table<Album> key(title) albums = table [
    {title: "Blue Train", artist: "John Coltrane"},
    {title: "Jeru", artist: "Gerry Mulligan"}
];

service / on new http:Listener(9090) {

    // Request is defined in the signature parameter.
    resource function post albums(http:Request request) returns Album|error {
        json payload = check request.getJsonPayload();
        Album album = check payload.cloneWithType();
        albums.add(album);
        return album;
    }
}
