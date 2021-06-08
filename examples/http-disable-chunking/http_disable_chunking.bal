import ballerina/http;

// The HTTP client's chunking behavior can be configured as [CHUNKING_AUTO](https://docs.central.ballerina.io/ballerina/http/latest/constants#CHUNKING_AUTO),
// [CHUNKING_ALWAYS](https://docs.central.ballerina.io/ballerina/http/latest/constants#CHUNKING_ALWAYS),
// or [CHUNKING_NEVER](https://docs.central.ballerina.io/ballerina/http/latest/constants#CHUNKING_NEVER).
// In this example, it is set to `CHUNKING_NEVER`, which means that chunking never happens irrespective of the request size. 
// When chunking is set to `CHUNKING_AUTO`, chunking is done based on the request.
// [http1Settings](https://docs.central.ballerina.io/ballerina/http/latest/records/ClientHttp1Settings) annotation
// provides the chunking-related configurations.
final http:Client clientEndpoint = check new ("http://localhost:9090",
                        {http1Settings: {chunking: http:CHUNKING_NEVER}});

service / on new http:Listener(9092) {
    resource function get chunkingSample() returns json|error {
        //Invoke endpoint along with a JSON payload.
        json clientResponse =
            check clientEndpoint->post("/echo", {"name": "Ballerina"});
        return clientResponse;
    }
}

// A sample backend, which responds according to the chunking behavior.
service / on new http:Listener(9090) {
    resource function post echo(@http:Header{name:"Content-length"} string cLen)
             returns json {
        //Set the response with the content length.
        string value = "Length-" + cLen;
        return {"Outbound request content": value};
    }
}
