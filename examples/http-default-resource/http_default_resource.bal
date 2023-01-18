import ballerina/http;

service on new http:Listener(9090) {

    // The `default` accessor can be used to match with all methods including the standard HTTP methods
    // and custom methods. The rest param is used to represent the wildcard of the `resource path` in which any path
    // segment will get dispatched to the resource in the absence of an exact path match.
    resource function 'default [string... paths](http:Request req) returns string {
        return string `method: ${req.method}, path: ${paths.toString()}`;
    }
}
