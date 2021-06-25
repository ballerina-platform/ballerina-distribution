import ballerina/log;
import ballerina/http;

service / on new http:Listener(9090) {
    // The `clientKey` method arguments is considered as the value for 
    // `X-Client-Key` HTTP header.
    resource function post hello(@http:Header {name: "X-Client-Key"} 
                                string clientKey, @http:Payload json content) 
                                returns http:Accepted|http:Unauthorized {
        if "0987654321" != clientKey {
            http:Unauthorized unauthorized = {body: "Unauthorized request"};
            return unauthorized;
        }
        log:printInfo("Received authorized request ", payload = content);
        http:Accepted accepted = {
            body: "Request processed successfully"
        };
        return accepted;
    }
}
