import ballerina/http;
import ballerina/openapi;

listener http:Listener ep0 = new(80, config = {host: "petstore.openapi.io"});

listener http:Listener ep1 = new(443, config = {host: "petstore.swagger.io"});

@openapi:ServiceInfo {
    contract: "/var/folders/mz/xmjfm34s1n99v74_jtsbsdcw0000gn/T/openapi-cmd5033409960939893222/src/openapi/resources/petstoreTags.yaml",
    tags: [ "list" ]
}
@http:ServiceConfig {
    basePath: "/v1"
}

service petstoreTags on ep0, ep1 {

    @http:ResourceConfig {
        methods:["GET"],
        path:"/pets"
    }
    resource function listPets (http:Caller caller, http:Request req) returns error? {

    }

}
