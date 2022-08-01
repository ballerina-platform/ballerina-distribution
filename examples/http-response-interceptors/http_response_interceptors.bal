import ballerina/http;

final string interceptor_header = "responseHeader";
final string interceptor_header_value = "ResponseInterceptor";

// A `ResponseInterceptor` service class implementation. It intercepts the response 
// and adds a header before it is dispatched to the client. A `ResponseInterceptor`
// service class can have only one remote function : `interceptResponse`.
service class ResponseInterceptor {
    *http:ResponseInterceptor;

    // The `interceptResponse` remote function, which will be executed for all the
    // responses. A `RequestContext` is used to share data between interceptors.
    remote function interceptResponse(http:RequestContext ctx, 
                        http:Response res) returns http:NextService|error? {
        // Sets a header to the response inside the interceptor service.
        res.setHeader(interceptor_header, interceptor_header_value);
        // Returns the next interceptor in the pipeline or `nil` if there is no 
        // more interceptors to be returned. In case a `nil` value is returned, then,
        // the modified response will be returned to the client. In addtion to these
        // return values, an error is returned when the call fails.
        return ctx.next();
    }
}

// Engage interceptors at the listener level. Response interceptor services will be executed from
// tail to head.
listener http:Listener interceptorListener = new http:Listener(9090,
    // This interceptor pipeline will be executed for all of the services attached to this listener.
    interceptors = [new ResponseInterceptor()]
);

service /user on interceptorListener {

    resource function get greeting(http:Request req) returns string {
        return "Greetings!";
    }
}
