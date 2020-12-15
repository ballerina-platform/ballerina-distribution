import ballerina/http;
import ballerina/log;

service /foo on new http:Listener(9090) {

    resource function post bar(http:Caller caller, http:Request req) {
        // This method retrieves the request payload as a JSON.
        var payload = req.getJsonPayload();
        http:Response res = new;
        if (payload is json) {
            // Since the JSON is known to be valid, `untaint` the data denoting that the data is trusted and set the JSON to the response.
            res.setJsonPayload(<@untainted>payload);
        } else {
            res.statusCode = 500;
            res.setPayload(<@untainted>payload.message());
        }
        // Reply to the client with the response.
        var result = caller->respond(res);
        if (result is error) {
           log:printError("Error in responding", err = result);
        }
    }
}
