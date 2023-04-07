import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

table<Album> key(title) albums = table [];

service / on new http:Listener(9090) {

    // The `album` parameter in the payload annotation represents the entity body of the inbound request.
    resource function post albums(Album album) returns Album {
        albums.add(album);
        return album;
    }
}
