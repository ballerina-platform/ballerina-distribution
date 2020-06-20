import ballerina/test;

string[] outputs = [];
int counter = 0;

@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    outputs[counter] = s[0].toString();
    counter += 1;
}

@test:Config {}
function testFunc() {
    main();
    test:assertEquals(outputs[0], "------ Query Binary Type -------");
    test:assertEquals(outputs[1], "Result 1:");
    test:assertEquals(outputs[2], "ROW_ID=1 BLOB_TYPE=119 115 111 50 32 98 97 108 108 101 114 105 110 97 32 98 108 111 98 32 116 101 115 116 46 CLOB_TYPE=very long text BINARY_TYPE=119 115 111 50 32 98 97 108 108 101 114 105 110 97 32 98 105 110 97 114 121 32 116 101 115 116 46");
    test:assertEquals(outputs[3], "Result 2:");
    test:assertEquals(outputs[4], "row_id=1 blob_type=119 115 111 50 32 98 97 108 108 101 114 105 110 97 32 98 108 111 98 32 116 101 115 116 46 clob_type=very long text binary_type=119 115 111 50 32 98 97 108 108 101 114 105 110 97 32 98 105 110 97 114 121 32 116 101 115 116 46");
    test:assertEquals(outputs[5], "------ ********* -------");
    test:assertEquals(outputs[6], "------ Query Array Type -------");
    test:assertEquals(outputs[7], "Result 1:");
    test:assertEquals(outputs[8], "ROW_ID=1 INT_ARRAY=1 2 3 LONG_ARRAY=100000000 200000000 300000000 FLOAT_ARRAY=245.23 5559.49 8796.123 DOUBLE_ARRAY=245.23 5559.49 8796.123 BOOLEAN_ARRAY=true false true STRING_ARRAY=Hello Ballerina");
    test:assertEquals(outputs[9], "Result 2:");
    test:assertEquals(outputs[10], "row_id=1 int_array=1 2 3 long_array=100000000 200000000 300000000 float_array=245.23 5559.49 8796.123 double_array=245.23 5559.49 8796.123 boolean_array=true false true string_array=Hello Ballerina");
    test:assertEquals(outputs[11], "------ ********* -------");
    test:assertEquals(outputs[12], "------ Query Date Time Type -------");
    test:assertEquals(outputs[13], "Result 1:");
    test:assertEquals(outputs[15], "Result 2:");
    test:assertEquals(outputs[17], "------ ********* -------");
    test:assertEquals(outputs[18], "Sample executed successfully!");
}
