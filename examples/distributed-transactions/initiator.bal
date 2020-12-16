import ballerina/http;
import ballerina/log;
import ballerina/lang.'transaction as transactions;

// This is the initiator of the distributed transaction.
service / on new http:Listener(8080) {
    resource function get init(http:Caller conn, http:Request req) {
        http:Response res = new;
        log:print("Initiating transaction...");
        // When transaction statement starts, a distributed transaction context is created.
        transaction {
            // Print the information about the current transaction.
            log:print("Started transaction: " +
                          transactions:info().toString());

            // When a participant is called, the transaction context is propagated and
            // that participant joins the distributed transaction.
            boolean successful = callBusinessService();
            if (successful) {
                res.statusCode = http:STATUS_OK;
                // Run the `2-phase commit coordination` protocol.
                // All participants are prepared and depending on the joint outcome,
                // either a `notify commit` or `notify abort` will be sent to the participants.
                var commitResult = commit;
                if commitResult is () {
                    log:print("Transaction committed");
                } else {
                    log:printError("Transaction failed");
                }
            } else {
                res.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
                log:printError("Internal Server Error");
                rollback;
            }
        }

        // Send the response back to the client.
        var result = conn->respond(res);
        if (result is error) {
            log:printError("Could not send response back to client",
            {"error": result.message()});
        } else {
            log:print("Sent response back to client");
        }
    }
}

// This is the business function call to the participant.
transactional function callBusinessService() returns @tainted boolean {
    http:Client participantEP = new ("http://localhost:8889/stockquote/" +
                                        "update/updateStockQuote");

    // Generate the payload.
    float price = 100.00;
    json bizReq = {symbol: "GOODS", price: price};

    // Send the request to the backend service.
    http:Request req = new;
    req.setJsonPayload(bizReq);
    var result = participantEP->post("", req);
    log:print("Got response from bizservice");
    if (result is http:Response) {
        return result.statusCode == http:STATUS_OK;
    } else {
        return false;
    }
}
