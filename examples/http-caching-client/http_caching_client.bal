import ballerina/http;
import ballerina/io;

public function main() returns error? {
    // Caching can be enabled by setting `enabled:true` in the `cache` config of the client.
    // In this example, the `isShared` field of the `cacheConfig` is set
    // to `true`, as the cache will be a public cache in this particular scenario.
    //
    // The default caching policy is to cache a response only if it contains a
    // `cache-control` header and either an `etag` header, or a `last-modified`
    // header. The user can control this behaviour by setting the `policy` field of
    // the `cacheConfig`. Currently, there are only 2 policies:
    // `CACHE_CONTROL_AND_VALIDATORS` (the default policy) and `RFC_7234`.
    http:Client httpClient = check new ("localhost:9090",
        cache = {
            enabled: true,
            isShared: true
        }
    );
    string payload = check httpClient->get("/greeting");
    io:println(payload);
}
