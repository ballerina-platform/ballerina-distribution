import ballerina/http;

service / on new http:Listener(9090) {

    resource function get hello(http:Request req) returns http:Response|error {
        http:Client clientEP = check new ("http://httpstat.us");
        http:Response resp = check clientEP->forward("/200", req);
        return resp;
    }
}
