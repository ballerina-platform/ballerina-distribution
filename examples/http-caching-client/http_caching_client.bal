import ballerina/http;
import ballerina/log;

// HTTP caching is enabled by default for client endpoints. Caching can be
// disabled by setting `enabled=false` in the [cache config](https://docs.central.ballerina.io/ballerina/http/latest/records/CacheConfig)
// of the client endpoint. In this example, the `isShared` field of the `cacheConfig` is set
// to true, as the cache will be a public cache in this particular scenario.
//
// The default caching policy is to cache a response only if it contains a
// `cache-control` header and either an `etag` header or a `last-modified`
// header. The user can control this behaviour by setting the [policy](https://docs.central.ballerina.io/ballerina/http/latest/types#CachingPolicy)
// field of the `cacheConfig`. Currently, there are only 2 policies:
// [CACHE_CONTROL_AND_VALIDATORS](https://docs.central.ballerina.io/ballerina/http/latest/constants#CACHE_CONTROL_AND_VALIDATORS)
// (the default policy) and [RFC_7234](https://docs.central.ballerina.io/ballerina/http/latest/constants#RFC_7234).

http:Client cachingEP = check new ("http://localhost:8080",
                             {cache: {isShared: true}});

service /cache on new http:Listener(9090) {

    resource function get .(http:Caller caller, http:Request req) {
        var response = cachingEP->forward("/hello", req);

        if (response is http:Response) {
            // If the request was successful, an HTTP response will be
            // returned. In this example, the received response is
            // forwarded to the client through the outbound endpoint.
            var result = caller->respond(<@untainted>response);
            if (result is error) {
                log:printError("Failed to respond to the caller",
                                'error = result);
            }
        } else {
            // For failed requests, a `500` response is sent back to the
            // caller.
            http:Response res = new;
            res.statusCode = 500;
            res.setPayload((<@untainted error>response).message());
            var result = caller->respond(res);
            if (result is error) {
                log:printError("Failed to respond to the caller",
                                'error = result);
            }
        }
    }
}

json payload = {"message": "Hello, World!"};

// Sample backend service which serves cacheable responses.
service /hello on new http:Listener(8080) {

    resource function get .(http:Caller caller, http:Request req) {
        http:Response res = new;

        // The [ResponseCacheControl](https://docs.central.ballerina.io/ballerina/http/latest/classes/ResponseCacheControl)
        // object in the [Response](https://docs.central.ballerina.io/ballerina/http/latest/classes/Response) object can be
        // used for setting the cache control directives associated with the
        // response. In this example, the `max-age` directive is set to 15 seconds
        // indicating that the response will be fresh for 15 seconds. The
        // `must-revalidate` directive instructs that the cache should not
        // serve a stale response without validating it with the origin server
        // first. The `public` directive is set by setting `isPrivate=false`.
        // This indicates that the response can be cached even by intermediary
        // caches which serve multiple users.
        http:ResponseCacheControl resCC = new;
        resCC.maxAge = 15;
        resCC.mustRevalidate = true;
        resCC.isPrivate = false;

        res.cacheControl = resCC;

        // The [setETag()](https://docs.central.ballerina.io/ballerina/http/latest/classes/Response#setETag)
        // function can be used for generating ETags for `string`, `json`, and `xml` types. This uses the `getCRC32()`
        // function from the `ballerina/crypto` module for generating the ETag.
        res.setETag(payload);

        // The [setLastModified()](https://docs.central.ballerina.io/ballerina/http/latest/classes/Response#setLastModified)
        // function sets the current time as the `last-modified` header.
        res.setLastModified();

        res.setPayload(payload);
        // When sending the response, if the `cacheControl` field of the
        // response is set, and the user has not already set a `cache-control`
        // header, a `cache-control` header will be set using the directives set
        // in the [cacheControl](https://docs.central.ballerina.io/ballerina/http/latest/classes/ResponseCacheControl) object.

        var result = caller->respond(res);
        if (result is error) {
            log:printError("Failed to respond to the caller",
                            'error = result);
        }
    }
}
