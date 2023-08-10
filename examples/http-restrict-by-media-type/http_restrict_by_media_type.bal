import ballerina/http;

service / on new http:Listener(9090) {
    // The `consumes` and `produces` annotations of the resource configuration contains MIME types as
    // an array of strings. The resource can only consume/accept `text/plain` media type. Therefore,
    // the `Content-Type` header of the request must be `text/plain` types. The resource can produce
    // `application/xml` payloads. Therefore, you need to set the `Accept` header accordingly.
    @http:ResourceConfig {
        consumes: ["text/plain"],
        produces: ["application/xml"]
    }
    resource function post transform(@http:Payload string msg) returns xml|http:InternalServerError {
        if re `^[a-zA-Z]*$`.isFullMatch(msg) {
            return xml `<name>${msg}</name>`;
        }
        return { body: xml `<name>invalid string</name>`};
    }
}
