import ballerina/http;

type Params record {|
    string path;
    map<json> matrix;
|};

service / on new http:Listener(9090) {

    // The path param is defined as a part of the resource path along with the type and it is extracted from the
    // request URI.
    resource function get params/[string foo](http:Request req) returns Params {

        // Gets the `MatrixParams`.
        map<any> pathMParams = req.getMatrixParams("/params");
        var a = <string>pathMParams["a"];
        var b = <string>pathMParams["b"];
        string pathMatrixStr = string `a=${a}, b=${b}`;

        map<any> fooMParams = req.getMatrixParams("/params/" + foo);
        var x = <string>fooMParams["x"];
        var y = <string>fooMParams["y"];
        string fooMatrixStr = string `x=${x}, y=${y}`;
        map<json> matrixJson = {path: pathMatrixStr, foo: fooMatrixStr};

        return { path: foo, matrix: matrixJson};
    }
}
