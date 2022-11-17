import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

table<Album> key(title) albums = table [];

service / on new http:Listener(9090) {

    // The `album` parameter in the payload annotation represents the entity body of the inbound request.
    // For details, see https://lib.ballerina.io/ballerina/http/latest/records/HttpPayload.
    resource function post albums(@http:Payload Album album) returns Album {
        albums.add(album);
        return album;
    }
}
