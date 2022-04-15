import ballerina/http;

// Header name to be set to the response in the response interceptor.
final string interceptor_header1 = "X-responseHeader1";
final string interceptor_header2 = "X-responseHeader2";

// Header value to be set to the response in the response interceptor.
final string interceptor_header_value1 = "ResponseInterceptor1";
final string interceptor_header_value2 = "ResponseInterceptor2";

// A Response Interceptor service class implementation. It intercepts the response and adds a header before it is dispatched to the 
// client. A Response Interceptor service class can have only one remote function called `interceptResponse`.
service class ResponseInterceptor1 {
    *http:ResponseInterceptor;

    // The remote function `interceptResponse`, which will be executed for all responses. A `RequestContext` is 
    // used to share data between interceptors.
    remote function interceptResponse(http:RequestContext ctx, 
            http:Response res) returns http:NextService|error? {
        // Sets a header to the response inside the interceptor service.
        res.setHeader(interceptor_header1, interceptor_header_value1);
        // Returns the next interceptor in the pipeline or `nil` if there is no more interceptors to be returned.
        // In case a `nil` value is returned then the modified response will be returned to the client.
        // In addtion to these return values, an error is returned when the call fails.
        return ctx.next();
    }
}

// Creates a new Response Interceptor.
ResponseInterceptor1 responseInterceptor1 = new;

// Another Response Interceptor service class.
service class ResponseInterceptor2 {
    *http:ResponseInterceptor;

    remote function interceptResponse(http:RequestContext ctx, 
            http:Response res) returns http:NextService|error? {
        res.setHeader(interceptor_header2, interceptor_header_value2);
        return ctx.next();
    }
}

// Creates another new Response Interceptor.
ResponseInterceptor2 responseInterceptor2 = new;

// Creates an HTTP Listener and assigns the interceptors as a config parameter. 
// Interceptor services will be executed in the configured order i.e. request 
// interceptors are executed head to tail and response interceptors are executed
// tail to head.
listener http:Listener interceptorListener = new http:Listener(9090, config = { 
    // Interceptor pipeline.
    interceptors: [responseInterceptor2, responseInterceptor1] 
});

service / on interceptorListener {

    resource function get greeting(http:Request req) returns http:Response {
        // Create a new response.
        http:Response response = new;
        response.setTextPayload("Greetings!");
        return response;
    }
}
