import ballerina/http;
import ballerina/test;

http:Client clientEP = check new("https://localhost:9090",
    secureSocket = {
        cert: "../resource/path/to/public.crt"
    }
);

@test:Config {}
function testFunc() returns error? {
    string response = check clientEP->get("/foo/bar");
    test:assertEquals(response, "Hello, World!");
}
