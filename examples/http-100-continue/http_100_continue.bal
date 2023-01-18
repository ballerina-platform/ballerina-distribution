import ballerina/http;
import ballerina/log;

service / on new http:Listener(9090) {

    resource function post greeting(http:Caller caller, http:Request request)
            returns error? {
        // Check if the client expects a 100-continue response.
        if request.expects100Continue() {
            string mediaType = request.getContentType();
            if mediaType.toLowerAscii() == "text/plain" {
                // Send a `100-continue` response to the client.
                check caller->continue();
            } else {
                // Send a `417` response to ignore the payload as the content type is mismatched
                // with the expected content type.
                http:ExpectationFailed resp = {body: "Unprocessable Entity"};
                return caller->respond(resp);
            }
        }

        // The client starts sending the payload once it receives the
        // `100-continue` response. The payload that is sent by the client is retrieved.
        var payload = request.getTextPayload();
        if payload is string {
            log:printInfo(payload);
            check caller->respond("Hello World!\n");
        } else {
            http:InternalServerError resp = {body: payload.message()};
            check caller->respond(resp);
        }
    }
}
