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

    resource function get albums() returns http:Response {
        // Create a response and populate headers/payload.
        http:Response response = new;
        response.setPayload(albums.toArray());
        response.setHeader("x-music-genre", "Jazz");
        return response;
    }
}
