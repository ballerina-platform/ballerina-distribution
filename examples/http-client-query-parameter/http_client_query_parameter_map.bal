// Sends a `GET` request to the "/albums" resource with multiple query
// parameters provided together as an `http:QueryParams` value.
http:QueryParams queries = {
    "title": "Blue Train",
    "artist": "John Coltrane"
};

Album[] albums = check albumClient->/albums(params = queries);
io:println("Received albums: " + albums.toJsonString());
