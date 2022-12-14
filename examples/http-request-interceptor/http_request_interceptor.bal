import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

table<Album> key(title) albums = table [
        {title: "Blue Train", artist: "John Coltrane"},
        {title: "Jeru", artist: "Gerry Mulligan"}
    ];

// Header name to be set to the request in the request interceptor.
final string interceptor_header = "requestHeader";

// Header value to be set to the request in the request interceptor.
final string interceptor_header_value = "RequestInterceptor";

// A `Requestinterceptorservice` class implementation. It intercepts the request
// and adds a header before it is dispatched to the target service.
service class RequestInterceptor {
    *http:RequestInterceptor;

    // A default resource function, which will be executed for all the requests. 
    // A `RequestContext` is used to share data between the interceptors.
    // An accessor and a path can also be specified. In that case, the interceptor will be
    // executed only for the requests, which match the accessor and path.
    resource function 'default [string... path](http:RequestContext ctx,
            http:Request req) returns http:NextService|error? {
        // Sets a header to the request inside the interceptor service.
        req.setHeader(interceptor_header, interceptor_header_value);
        // Returns the next interceptor or the target service in the pipeline. 
        // An error is returned when the call fails.
        return ctx.next();
    }
}

// Interceptors can also be engaged at the listener level. In this case, the `RequestInterceptors`
// can have only the default path.
listener http:Listener interceptorListener = new http:Listener(9090);

// Engage interceptors at the service level. Request interceptor services will be executed from
// head to tail.
@http:ServiceConfig {
    // The interceptor pipeline. The base path of the interceptor services is the same as
    // the target service. Hence, they will be executed only for this particular service.
    interceptors: [new RequestInterceptor()]
}
service / on interceptorListener {

    resource function get albums(http:Request req) returns http:Ok|error {
        return {
            headers: {
                // Reads the request header added by the interceptor.
                "requestHeader": check req.getHeader(interceptor_header)
            },
            body: albums.toArray()
        };
    }
}
