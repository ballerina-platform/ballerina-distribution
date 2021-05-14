import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns @tainted error? {

    http:Client httpEndpoint = check new("http://localhost:9090");

    var response = httpEndpoint->get("/product/count?a=315&b=585", targetType = json);
    if (response is json) {
        test:assertEquals(response, {"count":900});
    } else {
        test:assertFail(msg = "Failed to call the endpoint");
    }

    response = httpEndpoint->get("/product/name?id=432423", targetType = string);
    if (response is string) {
        test:assertEquals(response, "product_432423");
    } else {
        test:assertFail(msg = "Failed to call the endpoint");
    }

    response = httpEndpoint->get("/product/detail?colour=red&colour=green", targetType = json);
    if (response is json) {
        test:assertEquals(response, {"product_colour":["red", "green"]});
    } else {
        test:assertFail(msg = "Failed to call the endpoint");
    }

    response = httpEndpoint->get("/product/part?bar=a&bar=b&foo=1&baz=bal", targetType = json);
    if (response is json) {
        test:assertEquals(response, {"foo":"1", "bar":["a", "b"], "all":{"bar":["a", "b"], "foo":["1"], "baz":["bal"]}});
    } else {
        test:assertFail(msg = "Failed to call the endpoint");
    }
}
