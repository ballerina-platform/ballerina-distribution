import ballerina/http;
import ballerina/test;

http:Client clientEP = check new("https://localhost:9090",
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        },
        cert: "../resource/path/to/public.crt",
        protocol: {
            name: http:TLS
        },
        ciphers: ["TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA"]
    }
);

@test:Config {}
function testFunc() returns error? {
    json payload = { "query": "{ greeting }" };
    json actualResponse = check clientEP->post("/graphql", payload);
    json expectedResponse = {
        data: {
            greeting: "Hello, World!"
        }
    };
    test:assertEquals(actualResponse, expectedResponse);
}
