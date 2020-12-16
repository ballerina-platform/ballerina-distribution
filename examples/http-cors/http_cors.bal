import ballerina/http;
import ballerina/log;

// Service-level [CORS config](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/http/records/CorsConfig) applies
// globally to each `resource`.
@http:ServiceConfig {
    cors: {
        allowOrigins: ["http://www.m3.com", "http://www.hello.com"],
        allowCredentials: false,
        allowHeaders: ["CORELATION_ID"],
        exposeHeaders: ["X-CUSTOM-HEADER"],
        maxAge: 84900
    }
}
service /crossOriginService on new http:Listener(9092) {

    // Resource-level [CORS config](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/http/records/CorsConfig)
    // overrides the service-level CORS headers.
    @http:ResourceConfig {
        cors: {
            allowOrigins: ["http://www.bbc.com"],
            allowCredentials: true,
            allowHeaders: ["X-Content-Type-Options", "X-PINGOTHER"]
        }
    }
    resource function get company(http:Caller caller, http:Request req) {
        http:Response res = new;
        json responseJson = {"type": "middleware"};
        res.setJsonPayload(responseJson);
        var result = caller->respond(res);
        if (result is error) {
            log:printError(result.message(), err = result);
        }
    }

    // Since there are no resource-level CORS configs defined here, the global
    // service-level CORS configs will be applied to this resource.
    resource function post lang(http:Caller caller, http:Request req) {
        http:Response res = new;
        json responseJson = {"lang": "Ballerina"};
        res.setJsonPayload(responseJson);
        var result = caller->respond(res);
        if (result is error) {
            log:printError(result.message(), err = result);
        }
    }
}
