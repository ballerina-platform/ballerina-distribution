import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client clientEndpoint = check new ("localhost:9090", httpVersion = http:HTTP_1_1,
                        http1Settings = {chunking: http:CHUNKING_NEVER});
    string response = check clientEndpoint->/payload.post({"name": "Ballerina"});
    test:assertEquals(response, "Outbound request content length: 20");
}

service / on new http:Listener(9090) {
    resource function post payload(@http:Header{name:"Content-length"} string cLen) returns string {
        //Set the response with the content length.
        return string `Outbound request content length: ${cLen}`;
    }
}
