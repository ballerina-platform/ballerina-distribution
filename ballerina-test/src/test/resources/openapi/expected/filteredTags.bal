import ballerina/http;
import ballerina/openapi;

listener http:Listener ep0 = new(80, config = {host: "petstore.openapi.io"});

listener http:Listener ep1 = new(443, config = {host: "petstore.swagger.io"});

@openapi:ServiceInfo {
    contract: "/var/folders/mz/xmjfm34s1n99v74_jtsbsdcw0000gn/T/openapi-cmd5033409960939893222/src/openapi/resources/petstoreTags.yaml",
    tags: [ "list" ]
}

service /v1 on ep0, ep1 {

    resource function get pets(http:Caller caller, http:Request req, int limit) returns error? {

    }

}
