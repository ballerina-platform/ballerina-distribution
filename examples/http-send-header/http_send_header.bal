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

    resource function get albums() returns record {|*http:Ok; Album[] body;|} {
        return {body: albums.toArray(), headers:{"x-music-genre":"Jazz"}};
    }
}
