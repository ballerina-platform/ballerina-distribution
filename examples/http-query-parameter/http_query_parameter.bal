import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
    int year;
|};

table<Album> key(title) albums = table [
    {title: "Blue Train", artist: "John Coltrane", year: 1958},
    {title: "Jeru", artist: "Gerry Mulligan", year: 1962}
];

service / on new http:Listener(9090) {

    // The `year` resource method argument is considered as the query parameter which is extracted from the request URI.
    resource function get albums(int year) returns Album[] {
        table<Album> selected = from Album album in albums
                     where album.year == year select album;
        return selected.toArray();
    }
}
