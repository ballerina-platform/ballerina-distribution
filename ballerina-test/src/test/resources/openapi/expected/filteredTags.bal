import ballerina/http;
import ballerina/openapi;

listener http:Listener ep0 = new(80, config = {host: "petstore.openapi.io"});

listener http:Listener ep1 = new(443, config = {host: "petstore.swagger.io"});


service /v1 on ep0, ep1 {

    resource function get pets(http:Caller caller, http:Request req,  int limit) returns error? {

    }

}