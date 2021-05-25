import ballerina/http;

service /cbr on new http:Listener(9090) {

    resource function post route(@http:Payload json jsonMsg)
            returns http:Response|http:InternalServerError|error {
        // Define the attributes associated with the client endpoint here.
        http:Client locationEP = check new ("http://www.mocky.io");

        // Get the `string` value relevant to the key `name`.
        json|error nameString = jsonMsg.name;

        http:Response|error response;
        http:InternalServerError errResponse = {};
        if (nameString is json) {
            if (nameString.toString() == "sanFrancisco") {
                // Here, [post](https://docs.central.ballerina.io/ballerina/http/latest/clients/Client#post) remote function represents the POST operation of
                // the HTTP client.
                // This routes the payload to the relevant service when the server
                // accepts the enclosed entity.
                response =
                        locationEP->post("/v2/594e018c1100002811d6d39a", ());

            } else {
                response =
                        locationEP->post("/v2/594e026c1100004011d6d39c", ());
            }

            if (response is http:Response) {
                return response;
            } else {
                errResponse.body = response.message();
            }
        } else {
            errResponse.body = nameString.message();
        }
        return errResponse;
    }
}
