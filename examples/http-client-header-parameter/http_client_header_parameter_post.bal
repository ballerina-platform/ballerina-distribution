// Sends a `POST` request to the "/album" resource.
// The query parameter can be provided as parameters in the `post` method invocation.
string albumId = check albumClient->/album.post({
        title: "Blue Train",
        artist: "John Coltrane"
    },
    // Headers can be specified as a `map<string|string[]>`
    {
        Accept: mime:APPLICATION_JSON
    }
);
io:println("Added album with id: " + albumId);
