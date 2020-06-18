import ballerina/http;
import ballerina/log;

// The [basePath](https://ballerina.io/learn/api-docs/ballerina/http/records/HttpServiceConfig.html) attribute
// associates a path to the service. When bound to a listener endpoint, the service will be accessible at the
// specified path.
@http:ServiceConfig {
    basePath: "/foo"
}
service echo on new http:Listener(9090) {
    // When the [methods](https://ballerina.io/learn/api-docs/ballerina/http/records/HttpResourceConfig.html) attribute
    // is used, it confines the resource to the HTTP methods specified. In this instance, only `POST` requests are
    // allowed. The `path` attribute associates a subpath to the resource (i.e., relative to the `basePath` given in
    // the [ServiceConfig](https://ballerina.io/learn/api-docs/ballerina/http/records/HttpServiceConfig.html) annotation).
    @http:ResourceConfig {
        methods: ["POST"],
        path: "/bar"
    }
    resource function echo(http:Caller caller, http:Request req) {
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
           log:printError("Error in responding", result);
        }
    }
}
