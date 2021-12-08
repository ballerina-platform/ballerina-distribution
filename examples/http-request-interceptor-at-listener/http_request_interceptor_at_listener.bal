import ballerina/http;

// Header name to be set to the request in the request interceptor.
final string interceptor_header1 = "X-requestHeader1";
final string interceptor_header2 = "X-requestHeader2";

// Header value to be set to the request in the request interceptor.
final string interceptor_header_value1 = "RequestInterceptor1";
final string interceptor_header_value2 = "RequestInterceptor2";

// A Request Interceptor service class implementation. It intercepts the request and adds a header before it is dispatched to the 
// target HTTP Resource. A Request Interceptor service class can have only one resource function.
service class RequestInterceptor1 {
    *http:RequestInterceptor;

    // A default resource function, which will be executed for all requests. A `RequestContext` is used to share data between 
    // interceptors. Resource methods are only allowed to return an `http:NextService|error?`.
    resource function 'default [string... path](http:RequestContext ctx, 
                            http:Request req) returns http:NextService|error? {
        // Sets a header to the request inside the interceptor service.
        req.setHeader(interceptor_header1, interceptor_header_value1);
        // Returns the next interceptor or the target service in the pipeline. An error is returned when the call fails.
        return ctx.next();
    }
}

// Creates a new Request Interceptor.
RequestInterceptor1 requestInterceptor1 = new;

// Another Request Interceptor service class.
service class RequestInterceptor2 {
    *http:RequestInterceptor;

    // This interceptor is only executed for GET requests with the default path. 
    resource function get [string... path](http:RequestContext ctx, 
                            http:Request req) returns http:NextService|error? {
        req.setHeader(interceptor_header2, interceptor_header_value2);
        return ctx.next();
    }
}

// Creates another new Request Interceptor.
RequestInterceptor2 requestInterceptor2 = new;

// Creates an HTTP Listener and assigns the interceptors as a config parameter. 
// Interceptor services will be executed in the configured order.
listener http:Listener interceptorListener = new http:Listener(9090, config = { 
    // Interceptor pipeline. Only interceptors with default path can be engaged 
    // at listener level.
    interceptors: [requestInterceptor1, requestInterceptor2] 
});

service / on interceptorListener {

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
