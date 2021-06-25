import ballerina/http;
import ballerina/log;

service / on new http:Listener(9090) {
    // The `clientKey` method arguments is considered as the value for
    // `X-Client-Key` HTTP header.
    resource function get hello(@http:Header {name: "X-Client-Key"}
            string clientKey) returns string {

        log:printInfo("Received header value: " + clientKey);
        return clientKey;
    }
}
