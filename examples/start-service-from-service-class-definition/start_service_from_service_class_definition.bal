import ballerina/http;
import ballerina/lang.runtime;

public type Album readonly & record {|
    string title;
    string artist;
|};

// The listener object is attached to the `albumService`.
// It receives inputs from the specified port 9090 and invokes the remote methods.
http:Listener httpListener = check new (9090);

public service class Service {
    *http:Service;

    table<Album> key(title) albums = table [
            {title: "Blue Train", artist: "John Coltrane"},
            {title: "Jeru", artist: "Gerry Mulligan"}
        ];

    resource function get albums() returns Album[] {
        return self.albums.toArray();
    }

    resource function post albums(@http:Payload Album album) {
        self.albums.add(album);
    }
}

public function main() returns error? {
    // Create an HTTP service.
    http:Service albumService = new Service();
    // Attach the service to the listener along with the resource path.
    check httpListener.attach(albumService);
    // Start the listener.
    check httpListener.'start();
    // Register the listener dynamically.
    runtime:registerListener(httpListener);
}
