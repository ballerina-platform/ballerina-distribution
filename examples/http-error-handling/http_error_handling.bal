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
    remote function interceptResponseError(error err) returns http:BadRequest {
        // In this case, all the errors are sent as `400 BadRequest` responses with a customized
        // media type and body. Moreover, you can send different status code responses according to
        // the error type.        
        return {
            mediaType: "application/org+json",
            body: {message: err.message()}
        };
    }
}

// Engage interceptors at the service level using `http:InterceptableService`. The base path of the
// interceptor services is the same as the target service. Hence, they will be executed only for
// this particular service.
service http:InterceptableService / on new http:Listener(9090) {

    // Service level error interceptors can handle errors occurred during the service execution.
    public function createInterceptors() returns ResponseErrorInterceptor {
        // To handle all of the errors, the `ResponseErrorInterceptor` is added as a first
        // interceptor as it has to be executed last.
        return new ResponseErrorInterceptor();
    }

    // If the request does not have an`x-api-version` header, then an error will be returned
    // and the execution will jump to the nearest `ResponseErrorInterceptor`.
    resource function get albums(@http:Header {name: "x-api-version"} string xApiVersion)
            returns Album[]|http:NotImplemented {
        if xApiVersion != "v1" {
            return http:NOT_IMPLEMENTED;
        }
        return albums.toArray();
    }
}
