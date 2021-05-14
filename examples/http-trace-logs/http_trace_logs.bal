import ballerina/http;

service /hello on new http:Listener(9090) {

    resource function get .(http:Request req)
            returns http:Response|http:InternalServerError {
        // Create a new [http:Client](https://docs.central.ballerina.io/ballerina/http/latest/clients/Client).
        http:Client clientEP = checkpanic new ("http://httpstat.us");

        // Forward incoming requests to the remote backend.
        var resp = clientEP->forward("/200", req);

        if (resp is http:Response) {
            // Send response to the caller.
            return resp;

        } else {
            return {body:"Failed to fulfill request"};
        }
    }
}
