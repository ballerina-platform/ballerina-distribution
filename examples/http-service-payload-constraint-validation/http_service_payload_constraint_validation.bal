import ballerina/http;
import ballerina/constraint;

type Album record {
    @constraint:String {
        maxLength: 5,
        minLength: 1
    }
    string title;
    string artist;
};

service / on new http:Listener(9090) {

    final Album[] albums = [];

    // The `album` parameter in the payload annotation will get validated according to the
    // constraints added. If the constraint fails, a `400 Bad Request` will be sent to the client.
    resource function post albums(@http:Payload Album album) returns http:Created {
        self.albums.push(album);
        return http:CREATED;
    }
}
