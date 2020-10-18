import ballerina/http;
import ballerina/log;

type Person record {|
    string name;
    int age;
|};
type MapOfJson map<json>;

http:Client backendClient = new("http://localhost:9092");

service call on new http:Listener(9090) {

    @http:ResourceConfig {
        path: "/all"
    }
    resource function bindCheck(http:Caller caller, http:Request request)
                                                    returns @tainted error? {
        // string payload, proper handing
        var result = backendClient->
                        get("/backend/getString", targetType = string);

        if (result is error) {
            log:printError("Error: " + result.message);
        }
        log:printInfo("String payload: " + <string>result);

        // json binding with check and cast
        json jsonPayload = <json> check backendClient->
                                    get("/backend/getJson", json);

        log:printInfo("Json payload: " + jsonPayload.toJsonString());

        // maps and array
        map<json> value = <map<json>> check backendClient->
                                        get("/backend/getJson", MapOfJson);
        log:printInfo(check value.id);

        // record binding
        Person person = <Person> check backendClient->
                                    get("/backend/getPerson", Person);
        log:printInfo("Person name: " + person.name);

        // by default
        http:Response res =  <http:Response> check backendClient->
                                                get("/backend/getResponse");
        var result = caller->respond(res);
    }

    @http:ResourceConfig {
        path: "/500"
    }
    resource function handle500Error(http:Caller caller, http:Request request) {
        var res = backendClient->post("/backend/get5XX", "want 500", json);
        if (res is http:RemoteServerError) {
            http:Response resp = new;
            resp.statusCode = res.detail()?.statusCode ?: 500;
            resp.setPayload(<@untainted>res.message());
            var responseToCaller = caller->respond(<@untainted>resp);
        } else {
            json p = <json>res;
            var responseToCaller = caller->respond(<@untainted>p);
        }
    }

    @http:ResourceConfig {
        path: "/404"
    }
    resource function handle404Error(http:Caller caller, http:Request request) {
        var res = backendClient->post("/backend/", "want 500", json);
        if (res is http:ClientRequestError) {
            http:Response resp = new;
            resp.statusCode = res.detail()?.statusCode ?: 400;
            resp.setPayload(<@untainted>res.message());
            var responseToCaller = caller->respond(<@untainted>resp);
        } else {
            json p = <json>res;
            var responseToCaller = caller->respond(<@untainted>p);
        }
    }
}

@http:ServiceConfig {
    basePath: "/backend"
}
service mockService on new http:Listener(9092) {

    resource function getString(http:Caller caller, http:Request req) {
        http:Response response = new;
        response.setTextPayload("Hello ballerina!!!!");
        var result = caller->respond(response);
    }

    resource function getJson(http:Caller caller, http:Request req) {
        http:Response response = new;
        response.setJsonPayload({id: "Ballerina", values: {a: {x: "b"}}});
        var result = caller->respond(response);
    }

    resource function getPerson(http:Caller caller, http:Request req) {
        http:Response response = new;
        response.setJsonPayload({name: "Smith", age: 15});
        var result = caller->respond(response);
    }

    resource function getResponse(http:Caller caller, http:Request req) {
        http:Response response = new;
        response.setJsonPayload({id: "data-binding-done"});
        response.setHeader("x-fact", "backend-payload");
        var result = caller->respond(response);
    }

    resource function get5XX(http:Caller caller, http:Request req) {
        http:Response response = new;
        response.statusCode = 501;
        response.setTextPayload("data-binding-failed-with-501");
        var result = caller->respond(response);
    }

    resource function get4XX(http:Caller caller, http:Request req) {
        http:Response response = new;
        response.statusCode = 400;
        response.setTextPayload("data-binding-failed-due-to-bad-request");
        var result = caller->respond(response);
    }
}
