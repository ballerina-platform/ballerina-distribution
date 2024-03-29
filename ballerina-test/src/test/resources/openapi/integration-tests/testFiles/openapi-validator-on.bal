import ballerina/http;
import ballerina/log;
import ballerina/openapi;

listener http:Listener ep0 = new(9090, config = {host: "localhost"});

@openapi:ServiceInfo {
        contract: "openapi_validator_on.yaml",
        failOnErrors: true
}
service /api/v1 on ep0{
    resource function get [string param1]/[string param3](http:Caller caller) returns error? {
        string msg = "Hello, " + param1 + " " + param3 ;
        var result = caller->respond(<@untainted> msg);
        if (result is error) {
            log:printError("Error sending response", result);
        }
    }
}
