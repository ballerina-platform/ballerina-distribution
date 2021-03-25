import ballerina/http;
import ballerina/log;

// This is a participant in the distributed transaction. It will get invoked when it receives
// a transaction context from the participant.
service /stockquote on new http:Listener(8889) {
    // Since the transaction context has been received, this resource will register with the initiator
    // as a participant.
    transactional resource function post update/updateStockQuote
                                     (http:Caller conn, http:Request req) {
        log:printInfo("Received update stockquote request");
        // Get the JSON payload.
        json|http:ClientError updateReq = <@untainted>req.getJsonPayload();

        // Generate the response.
        http:Response res = new;
        if (updateReq is json) {
            log:printInfo("Update stock quote request received. " +
                          updateReq.toJsonString());
            json jsonRes = {"message": "updating stock"};
            res.statusCode = http:STATUS_OK;
            res.setJsonPayload(jsonRes);
        } else {
            res.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
            res.setPayload(updateReq.message());
            log:printError("Payload error occurred!", 'error = updateReq);
        }

        // Send the response back to the initiator.
        var result = conn->respond(res);
        if (result is error) {
            log:printError("Could not send response back to initiator",
            'error = result);
        } else {
            log:printInfo("Sent response back to initiator");
        }
    }
}
