import ballerina/http;

// Caching can be enabled by setting `enabled:true` in the `cache` config of the client.
// In this example, the `isShared` field of the `cacheConfig` is set
// to true, as the cache will be a public cache in this particular scenario.
//
// The default caching policy is to cache a response only if it contains a
// `cache-control` header and either an `etag` header, or a `last-modified`
// header. The user can control this behaviour by setting the `policy` field of
// the `cacheConfig`. Currently, there are only 2 policies:
// `CACHE_CONTROL_AND_VALIDATORS` (the default policy) and `RFC_7234`.

http:Client cachingEP = checkpanic new ("http://localhost:8080",
                        {cache: {enabled: true, isShared: true}});
service / on new http:Listener(9090) {

    resource function get cache(http:Request req)
            returns http:Response|error? {
        http:Response response = check cachingEP->forward("/hello", req);
        // If the request was successful, an HTTP response will be
        // returned.
        return response;
    }
}

service / on new http:Listener(8080) {

    resource function 'default hello() returns http:Response {
        http:Response res = new;
        // The `ResponseCacheControl` object in the `Response` object can be
        // used for setting the cache control directives associated with the
        // response. In this example, `max-age` directive is set to 15 seconds
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
        json payload = {"message": "Hello, World!"};

        // The `setETag()` function can be used for generating ETags for
        // `string`, `json`, and `xml` types. This uses the `getCRC32()`
        // function from the `ballerina/crypto` module for generating the ETag.
        res.setETag(payload);

        // The `setLastModified()` function sets the current time as the
        // `last-modified` header.
        res.setLastModified();

        res.setPayload(payload);
        // When sending the response, if the `cacheControl` field of the
        // response is set, and the user has not already set a `cache-control`
        // header, a `cache-control` header will be set using the directives set
        // in the `cacheControl` object.
        return res;

    }
}
