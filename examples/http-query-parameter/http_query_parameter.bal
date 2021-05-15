import ballerina/http;

service /product on new http:Listener(9090) {

    // The `a`, `b` method arguments are considered as query parameters.
    resource function get count(int a, int b) returns json {
        return { count : a + b};
    }

    // The query param type is nilable which means the URI may contain the param.
    // In the absence of the query param `id` the type is nil.
    resource function get name(string? id) returns string {
        if (id is string) {
            return "product_" + id;
        }
        return "product_0000";
    }

    // The multiple query param values also can be accommodate to an array.
    resource function get detail(string[]? colour) returns json {
        return { product_colour : colour};
    }

    // In addition to resource method argument, query params can be retrieved from the inbound request
    resource function get part(http:Request req) returns json {
        // Get the [first queryParam](https://docs.central.ballerina.io/ballerina/http/latest/classes/Request#getQueryParamValue)
        // value for a given parameter key.
        string? foo = req.getQueryParamValue("foo");

        // Get [multiple queryParam](https://docs.central.ballerina.io/ballerina/http/latest/classes/Request#getQueryParamValues)
        // values for a given parameter key.
        string[]? bar = req.getQueryParamValues("bar");

        // Get [all the queryParam](https://docs.central.ballerina.io/ballerina/http/latest/classes/Request#getQueryParams)
        // key value pairs of the inbound request.
        map<string[]> all = req.getQueryParams();

        return { foo: foo, bar: bar, all: all};
    }
}
