import ballerina/io;

function col3() returns boolean {
    return false;
}

type MyCSVRawTemplate object {
    *object:RawTemplate;
    public (string[] & readonly) strings;
    public [int, int, boolean] insertions;
};

public function main() {
    int col1 = 5;
    int col2 = 10;

    // No static type validation for interpolation
    object:RawTemplate rawTemplate = `${col1}, fixed_string1,  ${col2}, ${col3()}, fixed_string3`;
    io:println(rawTemplate.strings);
    io:println(rawTemplate.insertions);

    // validate interpolations at compile time
    MyCSVRawTemplate myCSVRawTemplate = `fixed_string4, ${col1}, ${col2}, fixed_string_5, ${col3()}`;
    io:println(myCSVRawTemplate.strings);
    io:println(myCSVRawTemplate.insertions);
}
