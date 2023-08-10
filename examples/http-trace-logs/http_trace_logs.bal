import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

service /info on new http:Listener(9095) {

    resource function get albums(http:Request req) returns Album[]|error {
        http:Client albumEP = check new ("localhost:9090");
        Album[] albums = check albumEP->forward("/albums", req);
        return albums;
    }
}
