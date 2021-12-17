import ballerina/http;

// Header name to be set to the request in the request interceptor.
final string interceptor_header1 = "X-requestHeader1";
final string interceptor_header2 = "X-requestHeader2";

// Header value to be set to the request in the request interceptor.
final string interceptor_header_value1 = "RequestInterceptor1";
final string interceptor_header_value2 = "RequestInterceptor2";

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

// Interceptor service class with specific path. This interceptor can only be engaged at service
// level.
service class RequestInterceptor2 {
    *http:RequestInterceptor;

    // This interceptor is only executed for GET requests with the relative path "greeting". 
    resource function get greeting(http:RequestContext ctx, 
                            http:Request req) returns http:NextService|error? {
        req.setHeader(interceptor_header2, interceptor_header_value2);
        return ctx.next();
    }
}

RequestInterceptor2 requestInterceptor2 = new;

listener http:Listener interceptorListener = new http:Listener(9090);

// Engage interceptors at service level.
@http:ServiceConfig {
    // The base path of interceptor services is same as the target service.
    interceptors: [requestInterceptor1, requestInterceptor2]
}
service /user on interceptorListener {

    resource function get greeting(http:Request req) 
            returns http:Response|error? {
        // Create a new response.
        http:Response response = new;
        // Set the interceptor headers from request
        response.setHeader(interceptor_header1, 
                            check req.getHeader(interceptor_header1));
        response.setHeader(interceptor_header2, 
                            check req.getHeader(interceptor_header2));
        response.setTextPayload("Greetings!");
        return response;
    }
}
