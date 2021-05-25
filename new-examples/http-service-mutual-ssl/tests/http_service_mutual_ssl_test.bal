import ballerina/http;
import ballerina/test;

http:Client securedEP = check new("https://localhost:9090",
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        },
        mutualSsl: {
            cert: "../resource/path/to/public.crt"
        },
        protocol: {
            name: http:TLS
        },
        ciphers: ["TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA"]
    }
);

@test:Config {}
function testFunc() {
    http:Response|error response = clientEP->get("/foo/bar");
    if (response is http:Response) {
        test:assertEquals(response.getTextPayload(), "Hello, World!");
    } else {
        test:assertFail(msg = "Failed to call the endpoint.");
    }
}
