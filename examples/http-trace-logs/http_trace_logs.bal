import ballerina/http;
import ballerina/log;

service /hello on new http:Listener(9090) {

    resource function get .(http:Caller caller, http:Request req) {
        // Create a new [http:Client](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/http/clients/Client).
        http:Client clientEP = new ("http://httpstat.us");
        // Forward incoming requests to the remote backend.
        var resp = clientEP->forward("/200", req);
        if (resp is http:Response) {
            // Respond to the caller.
            var result = caller->respond(<@untainted>resp);
            // Log the error in case of a failure.
            if (result is error) {
                log:printError("Failed to respond to caller", err = result);
            }
        } else {
            log:printError("Failed to fulfill request", err = <error>resp);
        }
    }
}
