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

    // Caller is defined in the signature parameter.
    resource function get albums(http:Caller caller) returns error? {
        http:Response response = new;
        response.setPayload(albums.toArray());
        response.setHeader("x-music-genre", "Jazz");

        // Sending the response using the caller functions.
        check caller->respond(response);
    }
}
