import ballerina/http;

listener http:Listener listenerEndpoint = new (9090);

// Since compression behavior of the service is set as [COMPRESSION_AUTO](https://docs.central.ballerina.io/ballerina/http/latest/constants#COMPRESSION_AUTO),
// entity body compression is done according to the scheme indicated in the `Accept-Encoding` request header.
// Compression is not performed when the header is not present or when the header value is "identity".
// [compression](https://docs.central.ballerina.io/ballerina/http/latest/records/CompressionConfig) annotation
// provides the related configurations.
@http:ServiceConfig {
    compression: {
        enable: http:COMPRESSION_AUTO
    }
}
service /autoCompress on listenerEndpoint {

    resource function 'default .() returns json {
        return {"Type": "Auto compression"};
    }
}

// [COMPRESSION_ALWAYS](https://docs.central.ballerina.io/ballerina/http/latest/constants#COMPRESSION_ALWAYS)
// guarantees a compressed response entity body. Compression scheme is set to the
// value indicated in Accept-Encoding request header. When a particular header is not present or the header
// value is "identity", encoding is done using the "gzip" scheme.
// By default, Ballerina compresses any MIME type unless they are mentioned under `contentTypes`.
// Compression can be constrained to certain MIME types by specifying them as an array of MIME types.
// In this example encoding is applied to "text/plain" responses only.
@http:ServiceConfig {
    compression: {
        enable: http:COMPRESSION_ALWAYS,
        contentTypes: ["text/plain"]
    }
}
service /alwaysCompress on listenerEndpoint {

    // Since compression is only constrained to "text/plain" MIME type,
    // `getJson` resource does not compress the response entity body.
    resource function 'default getJson() returns json {
        return {"Type": "Always but constrained by content-type"};
    }
    // The response entity body is always compressed since MIME type has matched.
    resource function 'default getString() returns string {
        return "Type : This is a string";
    }
}

// The HTTP client can indicate the [compression](https://docs.central.ballerina.io/ballerina/http/latest/types#Compression)
// behavior ("AUTO", "ALWAYS", "NEVER") for content negotiation.
// Depending on the compression option values, the `Accept-Encoding` header is sent along with the request.
// In this example, the client compression behavior is set as [COMPRESSION_ALWAYS](https://docs.central.ballerina.io/ballerina/http/latest/constants#COMPRESSION_ALWAYS). If you have not specified
// an `Accept-Encoding` header, the client specifies it with "deflate, gzip". Alternatively, the existing header is sent.
// When compression is specified as [COMPRESSION_AUTO](https://docs.central.ballerina.io/ballerina/http/latest/constants#COMPRESSION_AUTO), only the user-specified `Accept-Encoding` header is sent.
// If the behavior is set as [COMPRESSION_NEVER](https://docs.central.ballerina.io/ballerina/http/latest/constants#COMPRESSION_NEVER), the client makes sure not to send the `Accept-Encoding` header.
http:Client clientEndpoint = checkpanic new ("http://localhost:9090", {
        compression: http:COMPRESSION_ALWAYS
    }
);

service /passthrough on new http:Listener(9092) {

    resource function 'default .(http:Request req) returns http:Response|json {
        var response = clientEndpoint->post("/backend/echo", <@untainted>req);
        if (response is http:Response) {
            return response;
        } else {
            return {"error": "error occurred while invoking service"};
        }
    }
}

// The compression behavior of the service is inferred by [COMPRESSION_AUTO](https://docs.central.ballerina.io/ballerina/http/latest/constants#COMPRESSION_AUTO), which is the default value
// of the compression config.
service /backend on listenerEndpoint {
    resource function 'default echo(@http:Header{name:"accept-encoding"}
            string? accept) returns string {
        if (accept is string) {
            return "Backend response was encoded : " + accept;
        } else {
            return "Accept-Encoding header is not present";
        }
    }
}
