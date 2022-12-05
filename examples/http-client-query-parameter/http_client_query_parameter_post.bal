// Sends a `POST` request to the "/album" resource.
// The query parameter can be provided as parameters in the `post` method invocation.
string albumId = check albumClient->/album.post({
        title: "Sarah Vaughan and Clifford Brown",
        artist: "Sarah Vaughan"
    },
    apiVersion = 2
);
io:println("Added album with id: " + albumId);
