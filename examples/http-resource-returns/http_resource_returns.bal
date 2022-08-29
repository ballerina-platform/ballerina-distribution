import ballerina/http;

type PersonAccount record {
    string name;
    int accountNo;
};

service /bank on new http:Listener(9090) {

    // The resource returns the json type values and the `Content-type` header is set according to the `mediaType`
    // field of `@http:Payload` annotation. 
    // For details, see https://lib.ballerina.io/ballerina/http/latest/records/HttpPayload.
    resource function get branch() returns @http:Payload {mediaType:"application/json+id"} json {
        return { branch : ["Colombo, Srilanka"]};
    }

    // The StatusCodeResponse can be state as return type to send responses with specific HTTP status codes.
    // For details, see https://lib.ballerina.io/ballerina/http/latest/types#StatusCodeResponse.
    resource function get [string 'type]()
            returns http:Ok|http:InternalServerError {
        if 'type == "open" {

            // Create a response with the `200` status code and set the body as the response payload.
            http:Ok ok = {body: "Bank is open"};
            return ok;
        } else {

            // Creates response with 500 status code and set body as response payload.
            http:InternalServerError err = {body: "Bank is closed"};
            return err;
        }
    }

    // Inline response records are useful to return headers and body along with status code. In this instance the
    // return type is a subtype of the `http:Created` record, hence 201 response will be sent.
    // For details, see https://lib.ballerina.io/ballerina/http/latest/records/Created.
    resource function put account(@http:Payload string name)
            returns record {|*http:Created; PersonAccount body;|} {
        PersonAccount account = {accountNo: 84230, name: name};
        return {
            mediaType: "application/account+json",
            headers: {
                "Location": "/myServer/084230"
            },
            body: account
        };
    }
}
