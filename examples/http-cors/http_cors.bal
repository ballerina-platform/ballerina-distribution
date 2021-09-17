import ballerina/http;

// Service-level [CORS config](https://docs.central.ballerina.io/ballerina/http/latest/records/CorsConfig) applies
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

    // Resource-level [CORS config](https://docs.central.ballerina.io/ballerina/http/latest/records/CorsConfig)
    // overrides the service-level CORS headers.
    @http:ResourceConfig {
        cors: {
            allowOrigins: ["http://www.bbc.com"],
            allowCredentials: true,
            allowHeaders: ["X-Content-Type-Options", "X-PINGOTHER"]
        }
    }
    resource function get company() returns json {
        return {"type": "middleware"};
    }

    // Since there are no resource-level CORS configs defined here, the global
    // service-level CORS configs will be applied to this resource.
    resource function post lang() returns json {
        return {"lang": "Ballerina"};
    }
}
