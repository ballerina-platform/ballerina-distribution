import ballerina/http;

// Creates an HTTP client to interact with a remote endpoint.
// [followRedirects](https://docs.central.ballerina.io/ballerina/http/latest/records/FollowRedirects) record provides configurations associated with HTTP redirects.
http:Client clientEndpoint = check new ("http://localhost:9092", {
        followRedirects: {enabled: true, maxCount: 5}
    }
);

service / on new http:Listener(9090) {

    resource function get hello() returns string|error {
        // Sends a `GET` request to the specified endpoint and Retrieved the text payload from the response.
        string returnResult = check clientEndpoint->get("/redirect1");
        return "Response received : " + returnResult;
    }
}

service / on new http:Listener(9092) {

    resource function get redirect1(http:Caller caller) returns error? {
        http:Response res = new;
        // Sends a redirect response with a location.
        check caller->redirect(res,
            http:REDIRECT_TEMPORARY_REDIRECT_307,
            ["http://localhost:9093/redirect2"]);
    }
}

service /redirect2 on new http:Listener(9093) {

    resource function get .() returns string {
        // Sends a response to the caller.
        return "Hello World!";
    }
}
