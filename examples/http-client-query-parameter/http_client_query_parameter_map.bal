// Sends a `GET` request to the "/albums" resource with multiple query
// parameters provided together as an `http:QueryParams` value.
http:QueryParams queries = {
    "title": "Blue Train",
    "artist": "John Coltrane"
};

Album[] albums = check albumClient->/albums(params = queries);
io:println("Received albums: " + albums.toJsonString());

// http:QueryParams is a record type, so query parameters can also be
// provided as a map without declaring a variable of type
// http:QueryParams.
Album[] moreAlbums = check albumClient->/albums(params = {
    "title": "Jeru",
    "artist": "Gerry Mulligan"
});
io:println("Received albums: " + moreAlbums.toJsonString());
