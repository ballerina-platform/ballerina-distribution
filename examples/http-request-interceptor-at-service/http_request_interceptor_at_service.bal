import ballerina/http;

// Header name to be set to the request in the request interceptor.
final string interceptor_header1 = "X-requestHeader1";
final string interceptor_header2 = "X-requestHeader2";
final string interceptor_header3 = "X-requestHeader3";

// Header value to be set to the request in the request interceptor.
final string interceptor_header_value1 = "RequestInterceptor1";
final string interceptor_header_value2 = "RequestInterceptor2";
final string interceptor_header_value3 = "RequestInterceptor3";



service class RequestInterceptor1 {
    *http:RequestInterceptor;

    resource function 'default [string... path](http:RequestContext ctx, 
                            http:Request req) returns http:NextService|error? {
        // Sets a header to the request inside the interceptor service.
        req.setHeader(interceptor_header1, interceptor_header_value1);
        return ctx.next();
    }
}

RequestInterceptor1 requestInterceptor1 = new;

service class RequestInterceptor2 {
    *http:RequestInterceptor;

    resource function get [string... path](http:RequestContext ctx, 
                            http:Request req) returns http:NextService|error? {
        req.setHeader(interceptor_header2, interceptor_header_value2);
        return ctx.next();
    }
}

RequestInterceptor2 requestInterceptor2 = new;

// Interceptor service class with specific path. This interceptor can only be engaged at service
// level.
service class RequestInterceptor3 {
    *http:RequestInterceptor;

    // This interceptor is only executed for GET requests with the relative path "greeting". 
    resource function get greeting(http:RequestContext ctx, 
                            http:Request req) returns http:NextService|error? {
        req.setHeader(interceptor_header3, interceptor_header_value3);
        return ctx.next();
    }
}

RequestInterceptor3 requestInterceptor3 = new;

listener http:Listener interceptorListener = new http:Listener(9090, config = { 
    // At listener level, we can only add interceptors with default path.
    interceptors: [requestInterceptor1, requestInterceptor2] 
});

// Engage interceptors at service level.
@http:ServiceConfig {
    // When interceptors are enaged at service level. The base path of the interceptor
    // services is same as the target service base path.
    interceptors: [requestInterceptor3]
}
service /user on interceptorListener {

    resource function get greeting(http:Request req, http:Caller caller) 
            returns error? {
        // Create a new response.
        http:Response res = new;
        // Set the interceptor headers from request
        res.setHeader(interceptor_header1, 
                            check req.getHeader(interceptor_header1));
        res.setHeader(interceptor_header2, 
                            check req.getHeader(interceptor_header2));
        res.setHeader(interceptor_header3, 
                            check req.getHeader(interceptor_header3));
        res.setTextPayload("Greetings!");
        check caller->respond(res);
    }
}
