import ballerina/http;

type BankInfo record {
    string name;
    string[] branches;
};

service /bank on new http:Listener(9090) {

    // The resource returns the `BankInfo` typed values and the `Content-type` header is set according to the `mediaType`
    // field of `@http:Payload` annotation.
    // For details, see https://lib.ballerina.io/ballerina/http/latest/records/HttpPayload.
    resource function get info() returns @http:Payload {mediaType:"application/ld+json"} BankInfo {
        return { name: "ABC", branches : ["Colombo", "Kandy", "Galle"]};
    }
}
