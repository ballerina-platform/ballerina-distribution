// This is the Ballerina test for the secured connection (HTTPS) scenario.
import ballerina/test;

// Client endpoint configuration with the SSL configurations.
HelloWorldClient clientEp = check new ("https://localhost:9090", {
    secureSocket: {
        cert: "../resource/path/to/public.crt"
    }
});

@test:Config
function testSecuredSimpleService() returns error? {
    // Executes a simple remote call.
    string result = check clientEp->hello("WSO2");
    string expected = "Hello WSO2";
    test:assertEquals(result, expected);
}
