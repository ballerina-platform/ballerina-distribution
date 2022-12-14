import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

table<Album> key(title) albums = table [
        {title: "Blue Train", artist: "John Coltrane"},
        {title: "Sarah Vaughan and Clifford Brown", artist: "Sarah Vaughan"}
    ];

service class RequestInterceptor {
    *http:RequestInterceptor;

    // This resource will be executed only for POST requests with the path `albums`.
    resource function post albums(http:RequestContext ctx,
            @http:Payload Album album) returns http:NextService|error? {
        // Returns an error when the album is already present. This error can be intercepted in
        // the nearest error interceptor.
        if albums.hasKey(album.title) {
            return error("album is already present.");
        }
        // Otherwise continue the request flow.
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
    // execution can be accessed by the mandatory argument: `error`.
    resource function 'default [string... path](error err, http:Request req,
            http:RequestContext ctx) returns http:InternalServerError {
        // In this case, all of the errors are sent as `500 InternalServerError` 
        // responses with a customized media type and body. You can also send different
        // responses according to the error type. In addition, you can also call `ctx.next()`
        // if you want to continue the request flow after fixing the error.
        return {
            mediaType: "application/org+json",
            body: {message: err.message()}
        };
    }
}

// Creates a new `RequestErrorInterceptor`.
RequestErrorInterceptor requestErrorInterceptor = new;

listener http:Listener interceptorListener = new http:Listener(9090);

@http:ServiceConfig {
    // To handle all of the errors in this service path, the `RequestErrorInterceptor`
    // is added as the last interceptor as it has to be executed last.
    interceptors: [requestInterceptor, requestErrorInterceptor]
}
service / on interceptorListener {

    resource function post albums(@http:Payload Album album) returns Album|error {
        // No need to check the existance of the album since that is handled by the `RequestInterceptor`.
        albums.add(album);
        return album;
    }
}
