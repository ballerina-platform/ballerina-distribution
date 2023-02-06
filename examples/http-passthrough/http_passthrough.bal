import ballerina/http;

type Album readonly & record {
    string title;
    string artist;
};

http:Client clientEP = check new ("localhost:9090");

service / on new http:Listener(9092) {

    resource function 'default [string... path](http:Request req) returns Album[]|error {
        Album[] payload = check clientEP->forward("/albums", req);
        return payload;
    }
}
