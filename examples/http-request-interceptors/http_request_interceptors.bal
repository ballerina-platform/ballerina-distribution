import ballerina/http;

// Header names to be set to the request in the request interceptor.
final string interceptor_header1 = "requestHeader1";
final string interceptor_header2 = "requestHeader2";

// Header values to be set to the request in the request interceptor.
final string interceptor_header_value1 = "RequestInterceptor1";
final string interceptor_header_value2 = "RequestInterceptor2";

// A `Requestinterceptorservice` class implementation. It intercepts the request
// and adds a header before it is dispatched to the target service. A `RequestInterceptorService`
// class can have only one resource function.
service class RequestInterceptor1 {
    *http:RequestInterceptor;

    // A default resource function, which will be executed for all the requests. 
    // A `RequestContext` is used to share data between the interceptors.
    resource function 'default [string... path](http:RequestContext ctx, 
                        http:Request req) returns http:NextService|error? {
        // Sets a header to the request inside the interceptor service.
        req.setHeader(interceptor_header1, interceptor_header_value1);
        // Returns the next interceptor or the target service in the pipeline. 
        // An error is returned when the call fails.
        return ctx.next();
    }
}

// Creates a new `RequestInterceptor`.
RequestInterceptor1 requestInterceptor1 = new;

// An `Interceptor` service class with a specific path. This interceptor can only be 
// engaged at the service level.
service class RequestInterceptor2 {
    *http:RequestInterceptor;

    // This interceptor is executed only for GET requests with the relative path 
    // `greeting`. 
    resource function get greeting(http:RequestContext ctx, http:Request req)
            returns http:NextService|error? {
        req.setHeader(interceptor_header2, interceptor_header_value2);
        return ctx.next();
    }
}

// Creates another new `RequestInterceptor`.
RequestInterceptor2 requestInterceptor2 = new;

// Interceptors can also be engaged at the listener level. In this case, the `RequestInterceptors`
// can have only the default path.
listener http:Listener interceptorListener = new http:Listener(9090);

// Engage interceptors at the service level. Request interceptor services will be executed from
// head to tail.
@http:ServiceConfig {
    // The interceptor pipeline. The base path of the interceptor services is the same as
    // the target service. Hence, they will be executed only for this particular service.
    interceptors: [requestInterceptor1, requestInterceptor2]
}
service /user on interceptorListener {

    resource function get greeting(http:Request req) returns http:Ok|error {
        return {
            headers: {
                "requestHeader1": check req.getHeader(interceptor_header1),
                "requestHeader2": check req.getHeader(interceptor_header2)
            },
            mediaType: "application/org+json",
            body: {
                message: "Greetings!"
            }
        };
    }
}
