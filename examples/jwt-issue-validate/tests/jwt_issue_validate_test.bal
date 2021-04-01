import ballerina/test;

string[] outputs = [];

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
test:MockFunction mock_printLn = new();

public function mockPrint(any... val) {
    outputs.push(val.reduce(function (any a, any b) returns string => a.toString() + b.toString(), "").toString());
}

@test:Config {}
function testFunc() {
    test:when(mock_printLn).call("mockPrint");
    // Invoking the main function
    var ret = main();
    test:assertEquals(outputs.length(), 3);
    test:assertTrue(outputs[0].includes("Issued JWT: eyJhbGciOiJSUzI1NiIsICJ0eXAiOiJKV1QiLCAia2" +
        "lkIjoiTlRBeFptTXhORE15WkRnM01UVTFaR00wTXpFek9ESmhaV0k0TkRObFpEVTFPR0ZrTmpGaU1RIn0."));
    test:assertTrue(outputs[1].includes("Validated JWT Payload: {\"iss\":\"wso2\",\"sub\":" +
        "\"ballerina\",\"aud\":\"vEwzbcasJVQm1jVYHUHCjhxZ4tYa\","));
    test:assertTrue(outputs[2].includes("Validated JWT Payload: {\"iss\":\"wso2\",\"sub\":" +
        "\"ballerina\",\"aud\":\"vEwzbcasJVQm1jVYHUHCjhxZ4tYa\","));
}
