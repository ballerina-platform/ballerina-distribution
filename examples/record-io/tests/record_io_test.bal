import ballerina/test;
import ballerina/io;
import ballerina/stringutils;

(any|error)[] outputs = [];
int counter = 0;

// This is the mock function that replaces the real function.
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
test:MockFunction mock_printLn = new();

public function mockPrint(any|error... s) {
    outputs[counter] = s[0];
    counter += 1;
}

// This is the mock function that replaces the real function.
@test:Mock {
    functionName: "getReadableRecordChannel"
}
test:MockFunction mock_getReadableRecordChannel = new();

public function mockGetReadableRecordChannel(string filePath, string encoding,
                                             string rs, string fs)
                    returns io:ReadableTextRecordChannel|error {
    io:ReadableByteChannel byteChannel = check io:openReadableFile(filePath);
    io:ReadableCharacterChannel characterChannel = new(byteChannel, encoding);
    io:ReadableTextRecordChannel delimitedRecordChannel = new(characterChannel,
        rs = rs,
        fs = fs);
    return delimitedRecordChannel;
}

// This is the mock function that replaces the real function.
@test:Mock {
    functionName: "getWritableRecordChannel"
}
test:MockFunction mock_getWritableRecordChannel = new();

public function mockGetWritableRecordChannel(string filePath, string encoding,
                                             string rs, string fs)
                    returns io:WritableTextRecordChannel|error {
    io:WritableByteChannel byteChannel = check io:openWritableFile(filePath);
    io:WritableCharacterChannel characterChannel = new(byteChannel, encoding);
    io:WritableTextRecordChannel delimitedRecordChannel = new(characterChannel,
        rs = rs,
        fs = fs);
    return delimitedRecordChannel;
}

@test:Config{}
function testFunc() {
    test:when(mock_printLn).call("mockPrint");
    test:when(mock_getReadableRecordChannel).call("mockGetReadableRecordChannel");
    test:when(mock_getWritableRecordChannel).call("mockGetWritableRecordChannel");
    // Invoke the main function.
    main();
    string out1 = "Start processing the CSV file from ./files/sample.csv to the text file in";
    string out2 = "Processing completed. The processed file is located in";
    string actual1 = <string>outputs[0];
    string actual2 = <string>outputs[1];
    test:assertEquals(outputs.length(), 2);
    test:assertTrue(stringutils:contains(actual1, out1));
    test:assertTrue(stringutils:contains(actual2, out2));
}
