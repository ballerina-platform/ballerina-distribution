import ballerina/http;
import ballerina/io;

// Header name checked by the first response interceptor.
final string interceptor_check_header = "X-responseCheckHeader";

// Header value to be set to the response in the response error interceptor.
final string interceptor_check_header_value = "ResponseErrorInterceptor";

service class ResponseInterceptor1 {
    *http:ResponseInterceptor;

    remote function interceptResponse(http:RequestContext ctx, 
            http:Response res) returns http:NextService|error? {
        io:println("Executing Response Interceptor 1");
        // Tries to read the header. This will return a `HeaderNotFoundError` if
        // you do not set this header in the target service. Then, the execution will 
        // jump to the nearest `ResponseErrorInterceptor`.
        string checkHeader = check res.getHeader(interceptor_check_header);
        io:println("Check Header Value : " + checkHeader);
        return ctx.next();
    }
}

ResponseInterceptor1 responseInterceptor1 = new;

service class ResponseInterceptor2 {
    *http:ResponseInterceptor;

    remote function interceptResponse(http:RequestContext ctx, 
            http:Response res) returns http:NextService|error? {
        io:println("Executing Response Interceptor 2");
        return ctx.next();
    }
}

ResponseInterceptor2 responseInterceptor2 = new;

// A Response Error Interceptor service class implementation. It intercepts the 
// response when an error occurrs in the response path, and adds a header before
// it is returned to the client. Also, a Response Error Interceptor service class
// can have only one remote function called `interceptResponseError`.
service class ResponseErrorInterceptor {
    *http:ResponseErrorInterceptor;

    // The error occurred in the response path can be accessed by the mandatory argument : `error``.
    // The remote function can return a response which will overwrite the existing error
    // response.
    remote function interceptResponseError(error err, http:RequestContext ctx) 
            returns http:Response {
        io:println("Executing Response Error Interceptor");
        io:println("Error occurred : " + err.message());
        // Creates a new response.
        http:Response res = new;
        res.setTextPayload("Greetings from Interceptor!");
        // Sets a header to the response.
        res.setHeader(interceptor_check_header, interceptor_check_header_value);
        return res;
    }
}

// Creates a new Response Error Interceptor.
ResponseErrorInterceptor responseErrorInterceptor = new;

listener http:Listener interceptorListener = new http:Listener(9090, config = { 
    // A `ResponseErrorInterceptor` can be added anywhere in the interceptor pipeline.
    interceptors: [responseErrorInterceptor, responseInterceptor2, 
                   responseInterceptor1] 
});

service / on interceptorListener {

    resource function get greeting(http:Request req) returns string {
        io:println("Executing Target Resource");
        return "Greetings!";
    }
}
