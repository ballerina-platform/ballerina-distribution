import ballerina/http;

// The service-level CORS config applies globally to each `resource`.
// For details, see https://lib.ballerina.io/ballerina/http/latest/records/CorsConfig.
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

    // The resource-level CORS config overrides the service-level CORS headers.
    // For details, see https://lib.ballerina.io/ballerina/http/latest/records/CorsConfig.
    @http:ResourceConfig {
        cors: {
            allowOrigins: ["http://www.bbc.com"],
            allowCredentials: true,
            allowHeaders: ["X-Content-Type-Options", "X-PINGOTHER"]
        }
    }
    resource function get company() returns string {
        return "middleware";
    }

    // Since there are no resource-level CORS configs defined here, the global
    // service-level CORS configs will be applied to this resource.
    resource function post lang(@http:Payload string lang) returns string {
        return lang;
    }
}
