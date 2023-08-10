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

    // The request is defined in the signature parameter.
    resource function post albums(http:Request request) returns http:Response|error {
        json payload = check request.getJsonPayload();
        Album album = check payload.cloneWithType();
        albums.add(album);

        // Create a response and populate the headers/payload.
        http:Response response = new;
        response.setPayload(album);
        response.setHeader("x-music-genre", "Jazz");
        return response;
    }
}
