import ballerina/http;

// A `ResponseErrorInterceptor` service class implementation. It allows you
// to intercept the errors and handle them accordingly. A `ResponseErrorInterceptor`
// service can only have one remote function: `interceptResponseError`.
service class ResponseErrorInterceptor {
    *http:ResponseErrorInterceptor;

    // The error occurred in the request-response path can be accessed by the 
    // mandatory argument : `error`. The remote function can return a response,
    // which will overwrite the existing error response.
    remote function interceptResponseError(error err) returns http:InternalServerError {
        // In this case, all of the errors are sent as HTTP 500 internal server 
        // errors with a customized media type and body. Moreover, you can send different
        // responses according to the error type.        
        return {
            mediaType: "application/org+json",
            body: { message : err.message() }
        };
    }
}

// Creates a new `ResponseErrorInterceptor`.
ResponseErrorInterceptor responseErrorInterceptor = new;

// A `ResponseErrorInterceptor` can be configured at the listener level or 
// service level. Listener-level error interceptors can handle any error associated 
// with the listener, whereas, service-level error interceptors can only handle
// errors occurred during the service execution.
listener http:Listener interceptorListener = new http:Listener(9090, config = { 
    // To handle all of the errors, the `ResponseErrorInterceptor` is added as a first
    // interceptor as it has to be executed last.
    interceptors: [responseErrorInterceptor] 
});

service / on interceptorListener {

    // If the request does not include a `checkHeader`, then, this will return an error
    // and the execution will jump to the nearest `ResponseErrorInterceptor`.
    resource function get greeting(@http:Header string checkHeader) returns http:Ok {
        return {
            headers: {
                "checkedHeader" : checkHeader
            },
            mediaType: "application/org+json",
            body: { message : "Greetings!" }
        };
    }
}
