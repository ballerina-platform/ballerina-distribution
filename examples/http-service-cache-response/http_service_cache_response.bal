import ballerina/http;

service / on new http:Listener(9090) {

    resource function get greeting() returns http:Response {
        http:Response res = new;
        // The `http:ResponseCacheControl` object in the `http:Response` object can be
        // used for setting the cache control directives associated with the response.
        // In this example, `max-age` directive is set to 15 seconds indicating that the response
        // will be fresh for 15 seconds. The `must-revalidate` directive instructs that
        // the cache should not serve a stale response without validating it with the origin server
        // first. The `public` directive is set by setting `isPrivate=false`. This indicates that
        // the response can be cached even by intermediary caches which serve multiple users.
        http:ResponseCacheControl resCC = new;

        resCC.maxAge = 15;
        resCC.mustRevalidate = true;
        resCC.isPrivate = false;
        res.cacheControl = resCC;
        string payload = "Hello, World!";

        // The `setETag()` function can be used for generating ETags for
        // `string`, `json`, and `xml` types. This uses the `getCRC32()`
        // function from the `ballerina/crypto` module for generating the ETag.
        res.setETag(payload);

        // The `setLastModified()` function sets the current time as the `last-modified` header.
        res.setLastModified();

        res.setPayload(payload);
        // When sending the response, if the `cacheControl` field of the response is set, 
        // and the user has not already set a `cache-control` header, a `cache-control` header 
        // will be set using the directives set in the `cacheControl` object.
        return res;

    }
}
