import ballerina/http;

service /hello on new http:Listener(9090) {

    resource function get .(http:Request req) returns http:Response|error {
        http:Client clientEP = check new ("https://httpstat.us");
        http:Response resp = check clientEP->forward("/200", req);
        return resp;
    }
}
