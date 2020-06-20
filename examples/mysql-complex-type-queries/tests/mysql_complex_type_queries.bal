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

@test:Config {
    enable: false
}
function testFunc() {
    main();
    test:assertEquals(outputs[2], "row_id=1 blob_type=119 115 111 50 32 98 97 108 108 101 114 105 110 97 32 98 108 111 98 32 116 101 115 116 46 binary_type=119 115 111 50 32 98 97 108 108 101 114 105 110 97 32 98 105 110 97 114 121 32 116 101 115 116 46");
    test:assertEquals(outputs[4], "row_id=1 blob_type=119 115 111 50 32 98 97 108 108 101 114 105 110 97 32 98 108 111 98 32 116 101 115 116 46 binary_type=119 115 111 50 32 98 97 108 108 101 114 105 110 97 32 98 105 110 97 114 121 32 116 101 115 116 46");
    test:assertEquals(outputs[8], "row_id=1 date_type=2017-05-23+05:30 time_type=19:45:23.000+05:30 timestamp_type=2017-01-25T22:03:55.000+05:30 datetime_type=2017-01-25T22:03:55.000+05:30");
    test:assertEquals(outputs[10], "row_id=1 date_type=2017-05-23+05:30 time_type=51323000 timestamp_type=time=1485362035000 zone=id=UTC offset=0 datetime_type=2017-01-25T22:03:55.000+05:30");  
    test:assertEquals(outputs[12], "Sample executed successfully!");
}
