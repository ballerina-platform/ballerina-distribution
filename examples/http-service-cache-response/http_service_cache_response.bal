import ballerina/http;

service / on new http:Listener(9090) {

    // In this example, `max-age` directive is set to 15 seconds indicating that the response
    // will be fresh for 15 seconds. By default `must-revalidate` directive is true and instructs that
    // the cache should not serve a stale response without validating it with the origin server
    // first
    resource function get greeting() returns @http:Cache {maxAge: 15} string {
        return "Hello, World!";
    }
}
