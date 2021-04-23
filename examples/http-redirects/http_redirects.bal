import ballerina/http;
import ballerina/log;

// Creates an HTTP client to interact with a remote endpoint.
// [followRedirects](https://docs.central.ballerina.io/ballerina/http/latest/records/FollowRedirects) record provides configurations associated with HTTP redirects.
http:Client clientEndpoint = check new ("http://localhost:9092", {
        followRedirects: {enabled: true, maxCount: 5}
    }
);

service /hello on new http:Listener(9090) {

    resource function get .() returns string {
        // Sends a `GET` request to the specified endpoint.
        var returnResult = clientEndpoint->get("/redirect1");

        if (returnResult is http:Response) {
            // Retrieves the text payload from the response.
            var payload = returnResult.getTextPayload();

            if (payload is string) {
                return "Response received : " + <@untainted>payload;
            } else {
                return "Error in payload: " + <@untainted>payload.message();
            }
        } else {
            return "Connection error: " + <@untainted>returnResult.message();
        }
    }
}

service /redirect1 on new http:Listener(9092) {

    resource function get .(http:Caller caller) {
        http:Response res = new;
        // Sends a redirect response with a location.
        error? result = caller->redirect(res,
            http:REDIRECT_TEMPORARY_REDIRECT_307,
            ["http://localhost:9093/redirect2"]);

        if (result is error) {
            log:printError("Error in sending redirect response to caller",
                'error = result);
        }
    }
}

service /redirect2 on new http:Listener(9093) {

    resource function get .() returns string {
        // Sends a response to the caller.
        return "Hello World!";

    }
}
