import ballerina/http;

service / on new http:Listener(9090) {
    resource function get redirect(http:Caller caller) returns error? {
        http:Response res = new;
        // Sends a redirect response with a location header.
        check caller->redirect(res, http:REDIRECT_TEMPORARY_REDIRECT_307,
                            ["http://localhost:9092/greeting"]);
    }
}

service / on new http:Listener(9092) {
    resource function get greeting() returns string {
        return "Hello World!";
    }
}
