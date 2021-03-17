import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() {
    http:Client httpEndpoint = checkpanic new("https://localhost:9095", config = {
        secureSocket: {
            key: {
                certFile: "../resource/path/to/public.crt",
                keyFile: "../resource/path/to/private.key"
            },
            mutualSsl: {
                cert: "../resource/path/to/public.crt",
            }
            protocol: {
                name: http:TLS
            },
            ciphers: ["TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA"]
        }
    });

    string response1 = "Successful";
    var response = httpEndpoint->get("/hello");
    if (response is http:Response) {
        test:assertEquals(response.getTextPayload(), response1);
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }
}
