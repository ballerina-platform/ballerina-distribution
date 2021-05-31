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
}
