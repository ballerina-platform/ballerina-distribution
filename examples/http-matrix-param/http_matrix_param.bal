import ballerina/http;

service /sample on new http:Listener(9090) {

    // The path param is defined as a part of the resource path along with the type and it is extracted from the
    // request URI.
    resource function get path/[string foo](http:Request req) returns json {

        // Gets the [MatrixParams](https://docs.central.ballerina.io/ballerina/http/latest/classes/Request#getMatrixParams).
        map<any> pathMParams = req.getMatrixParams("/sample/path");
        var a = <string>pathMParams["a"];
        var b = <string>pathMParams["b"];
        string pathMatrixStr = string `a=${a}, b=${b}`;

        map<any> fooMParams = req.getMatrixParams("/sample/path/" + foo);
        var x = <string>fooMParams["x"];
        var y = <string>fooMParams["y"];
        string fooMatrixStr = string `x=${x}, y=${y}`;
        json matrixJson = {"path": pathMatrixStr, "foo": fooMatrixStr};

        // Create a JSON payload with the extracted values.
        json responseJson = {
            "pathParam": foo,
            "matrix": matrixJson
        };
        // Send a response with the JSON payload to the client.
        return responseJson;
    }
}
