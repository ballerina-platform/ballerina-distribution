import ballerina/http;

// The HTTP client's chunking behavior can be configured as [CHUNKING_AUTO](https://docs.central.ballerina.io/ballerina/http/latest/constants#CHUNKING_AUTO),
// [CHUNKING_ALWAYS](https://docs.central.ballerina.io/ballerina/http/latest/constants#CHUNKING_ALWAYS),
// or [CHUNKING_NEVER](https://docs.central.ballerina.io/ballerina/http/latest/constants#CHUNKING_NEVER).
// In this example, it is set to `CHUNKING_NEVER`, which means that chunking never happens irrespective of how it is
// specified in the request. When chunking is set to `CHUNKING_AUTO`, chunking is done as specified in the request.
// [http1Settings](https://docs.central.ballerina.io/ballerina/http/latest/records/ClientHttp1Settings) annotation
// provides the chunking-related configurations.
http:Client clientEndpoint = check new ("http://localhost:9090",
                        {http1Settings: {chunking: http:CHUNKING_NEVER}});

service /chunkingSample on new http:Listener(9092) {

    resource function get .() returns http:Response|http:InternalServerError {
        //Invoke endpoint with along with a JSON payload.
        var clientResponse = clientEndpoint->post("/echo/",
                                                  {"name": "Ballerina"});
        if (clientResponse is http:Response) {
            return clientResponse;
        } else {
            json msg =
                {"error": "An error occurred while invoking the service."};
            return {body: msg};
        }
    }
}

// A sample backend, which responds according to the chunking behavior.
service /echo on new http:Listener(9090) {

    resource function post .(@http:Header{name:"Content-length"} string? cLen,
             @http:Header{name:"Transfer-Encoding"} string? traEncoding)
             returns json|http:BadRequest {

        string value;
        //Set the response according to the request headers.
        if (cLen is string) {
            value = "Length-" + cLen;
            //Mark the `value` as trusted data and send out the JSON.
            return {"Outbound request content": <@untainted>value};
        }
        if (traEncoding is string) {
            value = traEncoding;
            //Perform data validation for transfer-encoding.
            if (value != "chunked" && value != "compress"
                && value != "deflate" && value != "gzip"
                && value != "identity") {
                value = "Transfer-Encoding contains invalid data";
                http:BadRequest badRequest = {body: value};
                return badRequest;
            } else {
                //Mark the `value` as trusted data and send out the JSON.
                return {"Outbound request content": <@untainted>value};
            }
        }
        value = "Neither Transfer-Encoding nor content-length header found";
        http:BadRequest badRequest = {body: value};
        return badRequest;
    }
}
