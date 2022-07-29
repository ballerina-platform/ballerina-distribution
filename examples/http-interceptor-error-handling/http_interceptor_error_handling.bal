import ballerina/http;
import ballerina/io;

// Header name checked by the request interceptor.
final string check_header = "checkHeader";

// Header value to be set to the request in the request error interceptor.
final string request_check_header_value = "RequestErrorInterceptor";

service class RequestInterceptor {
    *http:RequestInterceptor;

    // This will return a `HeaderNotFoundError` if you do not set this header. 
    // Then, the execution will jump to the nearest `RequestErrorInterceptor`.
    resource function 'default [string... path](http:RequestContext ctx,
            @http:Header string checkHeader) returns http:NextService|error? {
        io:println("Check Header Value : ", checkHeader);
        return ctx.next();
    }
}

RequestInterceptor requestInterceptor = new;

// A `RequestErrorInterceptor` service class implementation. It allows you to 
// intercept the error that occurred in the request path and handle it accordingly.
// A `RequestErrorInterceptor` service class can have only one resource function.
service class RequestErrorInterceptor {
    *http:RequestErrorInterceptor;

    // The resource function inside a `RequestErrorInterceptor` is only allowed 
    // to have the default method and path. The error occurred in the interceptor
    // execution can be accessed by the mandatory argument : `error`.
    resource function 'default [string... path](error err, http:Request req,
            http:RequestContext ctx) returns http:NextService|error? {
        // In this case, a header is set to the request, and then, the modified request
        // is dispatched to the target service. Moreover, you can send different 
        // responses according to the error type.
        req.setHeader(check_header, request_check_header_value);
        return ctx.next();
    }
}

// Creates a new `RequestErrorInterceptor`.
RequestErrorInterceptor requestErrorInterceptor = new;


listener http:Listener interceptorListener = new http:Listener(9090, config = {
    // To handle all of the errors in the request path, the `RequestErrorInterceptor`
    // is added as the last interceptor as it has to be executed last. 
    interceptors: [requestInterceptor, requestErrorInterceptor] 
});

service / on interceptorListener {

    resource function get greeting(@http:Header string checkHeader) returns http:Ok {
        return {
            headers: {
                "checkedHeader": checkHeader
            },
            mediaType: "application/org+json",
            body: {
                message: "Greetings!"
            }
        };
    }
}
