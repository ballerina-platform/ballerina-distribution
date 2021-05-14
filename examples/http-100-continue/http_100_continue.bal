import ballerina/http;
import ballerina/log;

service /hello on new http:Listener(9090) {

    resource function 'default .(http:Caller caller, http:Request request)
            returns string|http:InternalServerError|http:ExpectationFailed {
        // [Check if the client expects a 100-continue response](https://docs.central.ballerina.io/ballerina/http/latest/classes/Request#expects100Continue).
        if (request.expects100Continue()) {

            string mediaType = request.getContentType();
            if (mediaType.toLowerAscii() == "text/plain") {
                // Send a 100-continue response to the client.
                var result = caller->continue();

                if (result is error) {
                    log:printError("Error sending response", 'error = result);
                }
            } else {
                // Send a 417 response to ignore the payload since content type is mismatched
                // with the expected content type.
                http:ExpectationFailed resp = {body:"Unprocessable Entity"};
                return resp;

            }
        }

        // The client starts sending the payload once it receives the
        // 100-continue response. Retrieve the payload that is sent by the client.
        http:Response res = new;
        var payload = request.getTextPayload();
        if (payload is string) {
            log:printInfo(payload);
            return "Hello World!\n";
        } else {
            http:InternalServerError resp = {body:payload.message()};
            return resp;
        }
    }
}
