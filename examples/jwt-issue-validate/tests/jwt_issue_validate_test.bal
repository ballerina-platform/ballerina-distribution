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
    test:assertEquals(outputs.length(), 2);
    test:assertEquals(outputs[0], "Issued JWT: eyJhbGciOiJSUzI1NiIsICJ0eXAiOiJKV1QifQ.eyJzdWIiOiJKb2huIiwgImlzcyI6In" +
                                  "dzbzIiLCAiZXhwIjoxNTg2NDM3MzgwLCAianRpIjoiMTAwMDc4MjM0YmEyMyIsICJhdWQiOlsiYmFsbGV" +
                                  "yaW5hIiwgImJhbGxlcmluYVNhbXBsZXMiXX0.H67rsDKLmZJacI1NKMlYl6cCROS-rsLfW3Z2INvvDyHr" +
                                  "ntNau0P8FFoIc98D_c7UPe_L1_uV3no0nWweoWvzqQB8wfvduB6wKNxb1KGprIUF0ilxveQN1Vzab2Mvd" +
                                  "7SJCJ19tf6OcKort38C7ES0am5vsm0495OyaNVDAq3ixFP8WRacQW53b0ELc25QCYJJBLhjFBdXLpnx1b" +
                                  "oSjgS2vhTrg8bY8zlkoV3pJULfHmjS3JX0a_FBqqeB1yQqbIp1RxGrWzGg4nA6kPjGC1GwYvxjcCVQjY5" +
                                  "PWWsd9GAeCnnvmFE_Xy6Xenq5lfL2RWWO4H3yF8x_8hcLS9XidERGWQ");
    test:assertEquals(outputs[1], "Validated JWT Payload: iss=wso2 sub=John aud=ballerina ballerinaSamples jti=10007" +
                                  "8234ba23 exp=1592456075 customClaims=");
    test:assertEquals(outputs[1], "Validated JWT Payload: iss=wso2 sub=John aud=ballerina ballerinaSamples jti=10007" +
                                  "8234ba23 exp=1592456075 customClaims=");
}
