import ballerina/http;
import ballerina/log;

service /cbr on new http:Listener(9090) {

    resource function post route(http:Caller outboundEP, http:Request req) {
        // Define the attributes associated with the client endpoint here.
        http:Client locationEP = new ("http://www.mocky.io");

        // Get the `json` payload from the request message.
        var jsonMsg = req.getJsonPayload();

        if (jsonMsg is json) {
            // Get the `string` value relevant to the key `name`.
            json|error nameString = jsonMsg.name;
            http:Response|http:PayloadType|error response;
            if (nameString is json) {
                if (nameString.toString() == "sanFrancisco") {
                    // Here, [post](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/ballerina/http/latest/http/clients/Client#post) remote function represents the POST operation of
                    // the HTTP client.
                    // This routes the payload to the relevant service when the server
                    // accepts the enclosed entity.
                    response =
                           locationEP->post("/v2/594e018c1100002811d6d39a", ());

                } else {
                    response =
                           locationEP->post("/v2/594e026c1100004011d6d39c", ());
                }

                // Use the remote function [respond](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/ballerina/http/latest/http/clients/Caller#respond) to send the client response
                // back to the caller.
                if (response is http:Response) {
                    var result = outboundEP->respond(<@untainted>response);
                    if (result is error) {
                        log:printError("Error sending response", err = result);
                    }
                } else {
                    http:Response res = new;
                    res.statusCode = 500;
                    res.setPayload((<@untainted error>response).message());
                    var result = outboundEP->respond(res);
                    if (result is error) {
                        log:printError("Error sending response", err = result);
                    }
                }
            } else {
                http:Response res = new;
                res.statusCode = 500;
                res.setPayload(<@untainted>nameString.message());

                var result = outboundEP->respond(res);
                if (result is error) {
                    log:printError("Error sending response", err = result);
                }
            }
        } else {
            http:Response res = new;
            res.statusCode = 500;
            res.setPayload(<@untainted>jsonMsg.message());

            var result = outboundEP->respond(res);
            if (result is error) {
                log:printError("Error sending response", err = result);
            }
        }
    }
}
