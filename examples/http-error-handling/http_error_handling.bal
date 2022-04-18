import ballerina/http;

// Header names checked by the interceptors.
final string check_header = "X-checkHeader";
final string interceptor_check_header = "X-interceptorCheckHeader";

// Header value to be set to the request in the request error interceptor.
final string request_check_header_value = "RequestErrorInterceptor";

// Header value to be set to the response in the response error interceptor.
final string response_check_header_value = "ResponseErrorInterceptor";

service class RequestInterceptor {
    *http:RequestInterceptor;

    resource function 'default [string... path](http:RequestContext ctx, 
                            http:Request req) returns http:NextService|error? {
        // This will return a `HeaderNotFoundError` if you do not set this header. 
        // Then, the execution will jump to the nearest `RequestErrorInterceptor`.
        string checkHeader = check req.getHeader(check_header);
        return ctx.next();
    }
}

RequestInterceptor requestInterceptor = new;

service class RequestErrorInterceptor {
    *http:RequestErrorInterceptor;

    resource function 'default [string... path](error err, http:Request req, 
            http:RequestContext ctx) returns http:NextService|error? {
        // If you set the `interceptor_check_header` to the request, then we
        // set the following header to the request.
        if req.hasHeader(interceptor_check_header) {
            req.setHeader(check_header, request_check_header_value);
        }
        // Otherwise, the request will get dispatched to the target service
        return ctx.next();
    }
}

RequestErrorInterceptor requestErrorInterceptor = new;

service class ResponseErrorInterceptor {
    *http:ResponseErrorInterceptor;

    remote function interceptResponseError(error err, http:RequestContext ctx) 
            returns http:Response {
        // Creates a new response.
        http:Response res = new;
        res.setTextPayload("Greetings from Interceptor!");
        // Sets a header to the response.
        res.setHeader(check_header, response_check_header_value);
        return res;
    }
}

ResponseErrorInterceptor responseErrorInterceptor = new;

listener http:Listener interceptorListener = new http:Listener(9090, config = { 
    interceptors: [requestInterceptor, requestErrorInterceptor, 
                   responseErrorInterceptor] 
});

service / on interceptorListener {

    // If the request does not consists this header, then this will return an error
    // and, the execution will jump to the nearest `ResponseErrorInterceptor`.
    resource function get greeting(@http:Header{name: check_header} 
            string header) returns http:Response {
        // Creates a new response.
        http:Response res = new;
        res.setTextPayload("Greetings!");
        // Sets a header to the response.
        res.setHeader(check_header, header);
        return res;
    }
}
