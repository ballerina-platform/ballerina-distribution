import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

table<Album> key(title) albums = table [
    {title: "Blue Train", artist: "John Coltrane"},
    {title: "Jeru", artist: "Gerry Mulligan"}
];

// A `ResponseInterceptor` service class implementation. It intercepts the response 
// and adds a header before it is dispatched to the client.
service class ResponseInterceptor {
    *http:ResponseInterceptor;

    // The `interceptResponse` remote function will be executed for all the
    // responses. A `RequestContext` is used to share data between interceptors.
    remote function interceptResponse(http:RequestContext ctx,
            http:Response res) returns http:NextService|error? {
        // Sets a header to the response inside the interceptor service.
        res.setHeader("x-api-version", "v2");
        // Returns the next interceptor in the pipeline or `nil` if there is no 
        // more interceptors to be returned. In case a `nil` value is returned, then,
        // the modified response will be returned to the client. In addition to these
        // return values, an error is returned when the call fails.
        return ctx.next();
    }
}

// Engage interceptors at the listener level. Response interceptor services will be executed from
// tail to head.
listener http:Listener interceptorListener = new (9090,
    // This interceptor pipeline will be executed for all of the services attached to this listener.
    interceptors = [new ResponseInterceptor()]
);

service / on interceptorListener {

    resource function get albums() returns Album[] {
        return albums.toArray();
    }
}
