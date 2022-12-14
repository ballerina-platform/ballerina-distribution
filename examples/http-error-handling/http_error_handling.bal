import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

table<Album> key(title) albums = table [
    {title: "Blue Train", artist: "John Coltrane"},
    {title: "Sarah Vaughan and Clifford Brown", artist: "Sarah Vaughan"}
];

// A `ResponseErrorInterceptor` service class implementation.
service class ResponseErrorInterceptor {
    *http:ResponseErrorInterceptor;

    // The error occurred in the request-response path can be accessed by the 
    // mandatory argument: `error`. The remote function can return a response,
    // which will overwrite the existing error response.
    remote function interceptResponseError(error err) returns http:InternalServerError {
        // In this case, all of the errors are sent as `500 InternalServerError` 
        // responses with a customized media type and body. Moreover, you can send different
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

    resource function post albums(@http:Payload Album album) returns Album|error {
        // Returns an error when the album is already present. This error can be intercepted in
        // the nearest `ResponseErrorInterceptor`.
        if albums.hasKey(album.title) {
            return error("album is already present.");
        }
        albums.add(album);
        return album;
    }
}
