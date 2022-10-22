import ballerina/http;

// The HTTP client's chunking behavior can be configured as `CHUNKING_AUTO`,
// `CHUNKING_ALWAYS`, or `CHUNKING_NEVER` only available HTTP/1.1 protocol.
// For details, see https://lib.ballerina.io/ballerina/http/latest/constants#CHUNKING_AUTO,
// https://lib.ballerina.io/ballerina/http/latest/constants#CHUNKING_ALWAYS,  and
// https://lib.ballerina.io/ballerina/http/latest/constants#CHUNKING_NEVER.
// In this example, it is set to `CHUNKING_NEVER`, which means that chunking never happens irrespective of the request size.
// When chunking is set to `CHUNKING_AUTO`, chunking is done based on the request.
// The `http1Settings` annotation provides the chunking-related configurations.
// For details, see https://lib.ballerina.io/ballerina/http/latest/records/ClientHttp1Settings.
final http:Client clientEndpoint = check new ("http://localhost:9090", httpVersion = http:HTTP_1_1,
                        http1Settings = {chunking: http:CHUNKING_NEVER});

service / on new http:Listener(9092) {
    resource function get chunk() returns string|error {
        //Invoke endpoint along with a JSON payload.
        string response = check clientEndpoint->post("/payload", {"name": "Ballerina"});
        return response;
    }
}

// A sample backend, which responds according to the chunking behavior.
service / on new http:Listener(9090) {
    resource function post payload(@http:Header{name:"Content-length"} string cLen) returns string {
        //Set the response with the content length.
        return string `Outbound request content length: ${cLen}`;
    }
}
