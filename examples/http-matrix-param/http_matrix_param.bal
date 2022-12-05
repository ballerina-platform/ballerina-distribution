import ballerina/http;

type Params record {|
    string path;
    json matrix;
|};

service / on new http:Listener(9090) {

    // The path param is defined as a part of the resource path along with the type and it is extracted from the
    // request URI.
    resource function get params/[string foo](http:Request req) returns Params {

        // Gets the `MatrixParams`.
        map<any> pathMParams = req.getMatrixParams("/params");
        var a = <string>pathMParams["a"];
        var b = <string>pathMParams["b"];
        json matrix = {a: a, b: b};

        return {path: foo, matrix: matrix};
    }
}
