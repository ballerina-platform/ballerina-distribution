import ballerina/http;
import ballerina/log;

@http:ServiceConfig {
    basePath: "/cbr"
}
service contentBasedRouting on new http:Listener(9090) {

    // Use [resourceConfig](https://ballerina.io/swan-lake/learn/api-docs/ballerina/http/records/HttpResourceConfig.html) annotation to declare the HTTP method.
    @http:ResourceConfig {
        methods: ["POST"],
        path: "/route"
    }
    resource function cbrResource(http:Caller outboundEP, http:Request req) {
        // Define the attributes associated with the client endpoint here.
        http:Client locationEP = new ("http://www.mocky.io");

        // Get the `json` payload from the request message.
        var jsonMsg = req.getJsonPayload();

        if (jsonMsg is json) {
            // Get the `string` value relevant to the key `name`.
            json|error nameString = jsonMsg.name;
            http:Response|error clientResponse;
            if (nameString is json) {
                if (nameString.toString() == "sanFrancisco") {
                    // Here, [post](https://ballerina.io/swan-lake/learn/api-docs/ballerina/http/clients/Client.html#post) remote function represents the POST operation of
                    // the HTTP client.
                    // This routes the payload to the relevant service when the server
                    // accepts the enclosed entity.
                    clientResponse =
                           locationEP->post("/v2/594e018c1100002811d6d39a", ());

                } else {
                    clientResponse =
                           locationEP->post("/v2/594e026c1100004011d6d39c", ());
                }

                // Use the remote function [respond](https://ballerina.io/swan-lake/learn/api-docs/ballerina/http/clients/Caller.html#respond) to send the client response
                // back to the caller.
                if (clientResponse is http:Response) {
                    var result = outboundEP->respond(clientResponse);
                    if (result is error) {
                        log:printError("Error sending response", result);
                    }
                } else {
                    http:Response res = new;
                    res.statusCode = 500;
                    res.setPayload(clientResponse.message());
                    var result = outboundEP->respond(res);
                    if (result is error) {
                        log:printError("Error sending response", result);
                    }
                }
            } else {
                http:Response res = new;
                res.statusCode = 500;
                res.setPayload(<@untainted>nameString.message());

                var result = outboundEP->respond(res);
                if (result is error) {
                    log:printError("Error sending response", result);
                }
            }
        } else {
            http:Response res = new;
            res.statusCode = 500;
            res.setPayload(<@untainted>jsonMsg.message());

            var result = outboundEP->respond(res);
            if (result is error) {
                log:printError("Error sending response", result);
            }
        }
    }
}
