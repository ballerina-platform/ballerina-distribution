import ballerina/http;
import ballerina/openapi;

listener http:Listener ep0 = new(9090, config = {host: "localhost"});

@openapi:ServiceInfo {
        contract: "openapi_validator_on.yaml",
        failOnErrors: true
}
service /api/v1 on ep0{
    resource function get [string param1]/[string param3]() returns string? {
        string msg = "Hello, " + param1 + " " + param3 ;
        return msg;
    }
}
