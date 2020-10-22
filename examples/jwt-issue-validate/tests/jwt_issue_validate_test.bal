import ballerina/stringutils;
import ballerina/test;

string[] outputs = [];

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public isolated function mockPrint(any|error... val) {
    outputs.push(val.reduce(function (any|error a, any|error b) returns string => a.toString() + b.toString(), "").toString());
}

@test:Config { }
function testFunc() {
    // Invoking the main function
    var ret = main();
    test:assertEquals(outputs.length(), 3);
    test:assertTrue(stringutils:contains(<string>outputs[0], "Issued JWT: eyJhbGciOiJSUzI1NiIsICJ0eXAiOiJKV1QiLCAia2" +
                                         "lkIjoiTlRBeFptTXhORE15WkRnM01UVTFaR00wTXpFek9ESmhaV0k0TkRObFpEVTFPR0ZrTmpG" +
                                         "aU1RIn0."));
    test:assertTrue(stringutils:contains(<string>outputs[1], "Validated JWT Payload: {\"iss\":\"ballerina\",\"sub\":" +
                                    "\"admin\",\"aud\":[\"vEwzbcasJVQm1jVYHUHCjhxZ4tYa\"],\"jti\":\"100078234ba23\""));
    test:assertTrue(stringutils:contains(<string>outputs[2], "Validated JWT Payload: {\"iss\":\"ballerina\",\"sub\":" +
                                    "\"admin\",\"aud\":[\"vEwzbcasJVQm1jVYHUHCjhxZ4tYa\"],\"jti\":\"100078234ba23\""));
}
