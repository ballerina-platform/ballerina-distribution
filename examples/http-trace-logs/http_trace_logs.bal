import ballerina/http;

service / on new http:Listener(9090) {

    resource function get trace(http:Request req) returns string|error {
        http:Client clientEP = check new ("httpstat.us");
        string payload = check clientEP->forward("/200", req);
        return payload;
    }
}
