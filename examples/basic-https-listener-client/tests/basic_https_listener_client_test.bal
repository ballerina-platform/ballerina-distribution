import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("https://localhost:9095", config = {
        secureSocket: {
            cert: "../resource/path/to/public.crt"
        }
    });

    string response1 = "Hello World!";
    string response = check httpEndpoint->get("/hello");
    test:assertEquals(response, response1);
}
