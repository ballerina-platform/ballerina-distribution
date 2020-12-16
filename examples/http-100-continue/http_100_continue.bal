import ballerina/http;
import ballerina/log;

service /hello on new http:Listener(9090) {

    resource function 'default .(http:Caller caller, http:Request request) {
        // [Check if the client expects a 100-continue response](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/http/classes/Request#expects100Continue).
        if (request.expects100Continue()) {
            string mediaType = request.getContentType();
            if (mediaType.toLowerAscii() == "text/plain") {
                // Send a 100-continue response to the client.
                var result = caller->continue();
                if (result is error) {
                    log:printError("Error sending response", err = result);
                }
            } else {
                // Send a 417 response to ignore the payload since content type is mismatched
                // with the expected content type.
                http:Response res = new;
                res.statusCode = 417;
                res.setPayload("Unprocessable Entity");
                var result = caller->respond(res);
                if (result is error) {
                    log:printError("Error sending response", err = result);
                }
                return;
            }
        }

        // The client starts sending the payload once it receives the
        // 100-continue response. Retrieve the payload that is sent by the client.
        http:Response res = new;
        var payload = request.getTextPayload();
        if (payload is string) {
            log:print(payload);
            res.statusCode = 200;
            res.setPayload("Hello World!\n");
            var result = caller->respond(res);
            if (result is error) {
                log:printError("Error sending response", err = result);
            }
        } else {
            res.statusCode = 500;
            res.setPayload(<@untainted>payload.message());
            var result = caller->respond(res);
            if (result is error) {
                log:printError("Error sending response", err = result);
            }
        }
    }
}
