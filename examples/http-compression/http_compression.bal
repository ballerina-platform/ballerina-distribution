import ballerina/http;

// `COMPRESSION_ALWAY`S` guarantees a compressed response entity body. Compression scheme is set to the
// value indicated in Accept-Encoding request header. When a particular header is not present or the header
// value is "identity", encoding is done using the "gzip" scheme.
// For details, see https://lib.ballerina.io/ballerina/http/latest/constants#COMPRESSION_ALWAYS.
// By default, Ballerina compresses any MIME type unless they are mentioned under `contentTypes`.
// Compression can be constrained to certain MIME types by specifying them as an array of MIME types.
// In this example encoding is applied to "text/plain" responses only.
@http:ServiceConfig {
    compression: {
        enable: http:COMPRESSION_ALWAYS,
        contentTypes: ["text/plain"]
    }
}
service / on new http:Listener(9090) {

    // The response entity body is always compressed since MIME type has matched.
    resource function 'default alwaysCompress() returns string {
        return "Type : This is a string.";
    }
}
