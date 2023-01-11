import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

table<Album> key(title) albums = table [
    {title: "Blue Train", artist: "John Coltrane"},
    {title: "Jeru", artist: "Gerry Mulligan"}
];

type AlbumOk record {|
    *http:Ok;
    record {|
        string x\-music\-genre;
    |} headers;
    Album[] body;
|};

service / on new http:Listener(9090) {

    resource function get albums() returns AlbumOk {
        return {
            headers: {
                x\-music\-genre: "Jazz"
            },
            body: albums.toArray()
        };
    }
}
