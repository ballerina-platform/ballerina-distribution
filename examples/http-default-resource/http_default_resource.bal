import ballerina/http;

// The `absolute resource path` can be omitted, then it defaults to `/`.
service on new http:Listener(9090) {

    // The `default` accessor name can be used to match with all methods including standard HTTP methods
    // and custom methods. The rest param is used to represents the wildcard of `resource path` where any path
    // segment will get dispatched to the resource in the absence of an exact path match.
    resource function 'default [string... paths](http:Request req) returns json {
        return {method: req.method, path: paths};
    }

    // The resource is confined to `GET` requests with path `/greeting`
    resource function get greeting() returns string {
        return "Specific resource is invoked";
    }
}
