import ballerina/http;

service on new http:Listener(9092) {
    // The `consumes` and `produces` annotations of the [resource configuration](https://docs.central.ballerina.io/ballerina/http/latest/records/HttpResourceConfig)
    // contain MIME types as an array of strings. The resource can only consume/accept `text/json` and
    // `application/json` media types. Therefore, the `Content-Type` header
    // of the request must be in one of these two types. The resource can produce
    // `application/xml` payloads. Therefore, you need to set the `Accept` header accordingly.
    @http:ResourceConfig {
        consumes: ["text/json", "application/json"],
        produces: ["application/xml"]
    }
    resource function post infoService(@http:Payload json msg)
            returns xml|http:InternalServerError {
        // Get the value, which is relevant to the key "name".
        json|error nameString = msg.name;
        if (nameString is json) {
            // Create the XML payload and send back a response.
            xml name = xml `<name>${<string>nameString}</name>`;
            return name;
        }
        return { body: "Invalid json: `name` not present"};
    }
}
