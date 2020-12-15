import ballerina/http;
import ballerina/io;
import ballerina/log;

// This is a participant in the distributed transaction. It will get infected when it receives
// a transaction context from the participant.
service /stockquote on new http:Listener(8889) {
    // Since the transaction context has been received, this resource will register with initiator
    // as a participant.
    transactional resource function post update/updateStockQuote
                                     (http:Caller conn, http:Request req) {
        log:print("Received update stockquote request");
        // Get the json payload.
        json|http:ClientError updateReq = <@untainted>req.getJsonPayload();

        // Generate the response.
        http:Response res = new;
        if (updateReq is json) {
            string msg = io:sprintf("Update stock quote request received. " +
                    "symbol:%s, price:%s", updateReq.symbol, updateReq.price);
            log:print(msg);
            json jsonRes = {"message": "updating stock"};
            res.statusCode = http:STATUS_OK;
            res.setJsonPayload(jsonRes);
        } else {
            res.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
            res.setPayload(updateReq.message());
            log:printError("Payload error occurred!",
            {"error": updateReq.message()});
        }

        // Send the response back to the initiator.
        var result = conn->respond(res);
        if (result is error) {
            log:printError("Could not send response back to initiator",
            {"error": result.message()});
        } else {
            log:print("Sent response back to initiator");
        }
    }
}
