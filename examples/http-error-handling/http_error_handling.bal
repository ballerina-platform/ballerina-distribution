import ballerina/http;

// A Response Error Interceptor service class implementation. It allows you
// to intercept the errors and handle them accorrdingly. A Response Error 
// Interceptor service can only have one remote function: `interceptResponseError`.
service class ResponseErrorInterceptor {
    *http:ResponseErrorInterceptor;

    // The error occurred in the request-response path can be accessed by the 
    // mandatory argument : `error`. The remote function can return a response 
    // which will overwrite the existing error response.
    remote function interceptResponseError(error err) 
            returns http:InternalServerError {
        // In this case, all of the errors are sent as HTTP 500 Internal Server 
        // Error with customized media-type and body. Moreover, you can sent different
        // responses according to the error type.        
        return {
            mediaType: "application/org+json",
            body: {
                message : err.message()
            }
        };
    }
}

// Creates a new Response Error Interceptor.
ResponseErrorInterceptor responseErrorInterceptor = new;

// A `ResponseErrorInterceptor` can be configured at listener level or at
// service level. Listener level error interceptors can handle any error associated 
// with the listener, whereas, service level error interceptors can only handle
// errors occurred durring the service execution.
listener http:Listener interceptorListener = new http:Listener(9090, config = { 
    // To handle all of the errors, the `ResponseErrorInterceptor` is added as a first
    // interceptor as it has to be executed at last.
    interceptors: [responseErrorInterceptor] 
});

service / on interceptorListener {

    // If the request does not include `checkHeader`, then this will return an error
    // and, the execution will jump to the nearest `ResponseErrorInterceptor`.
    resource function get greeting(@http:Header string checkHeader) returns 
            http:Ok {
        return {
            headers: {
                "checkedHeader" : checkHeader
            },
            mediaType: "application/org+json",
            body: {
                message : "Greetings!"
            }
        };
    }
}
