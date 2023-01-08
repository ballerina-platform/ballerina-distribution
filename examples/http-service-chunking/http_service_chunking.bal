import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

table<Album> key(title) albums = table [
    {title: "Blue Train", artist: "John Coltrane"},
    {title: "Jeru", artist: "Gerry Mulligan"}
];

@http:ServiceConfig {
    chunking: http:CHUNKING_ALWAYS
}
service / on new http:Listener(9090, httpVersion = http:HTTP_1_1) {

    resource function get albums() returns Album[] {
        return albums.toArray();
    }
}
