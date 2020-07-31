import ballerina/stringutils;
import ballerina/test;

(any|error)[] outputs = [];
int counter = 0;

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    outputs[counter] = s[0];
    counter += 1;
}

@test:Config { }
function testFunc() {
    // Invoking the main function
    var ret = main();
    test:assertEquals(outputs.length(), 3);
    test:assertTrue(stringutils:contains(<string>outputs[0], "Issued JWT: eyJhbGciOiJSUzI1NiIsICJ0eXAiOiJKV1QiLCAia2" +
                                         "lkIjoiTlRBeFptTXhORE15WkRnM01UVTFaR00wTXpFek9ESmhaV0k0TkRObFpEVTFPR0ZrTmpG" +
                                         "aU1RIn0."));
    test:assertTrue(stringutils:contains(<string>outputs[1], "Validated JWT Payload: iss=ballerina sub=admin aud=vEw" +
                                         "zbcasJVQm1jVYHUHCjhxZ4tYa jti=100078234ba23"));
    test:assertTrue(stringutils:contains(<string>outputs[2], "Validated JWT Payload: iss=ballerina sub=admin aud=vEw" +
                                         "zbcasJVQm1jVYHUHCjhxZ4tYa jti=100078234ba23"));
}
