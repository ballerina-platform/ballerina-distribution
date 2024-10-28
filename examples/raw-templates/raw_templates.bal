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

    // Allow any value as interpolations since object:RawTemplate has any|error[] as insertions type.
    object:RawTemplate rawTemplate = `${col1}, fixed_string1,  ${col2}, ${col3()}, fixed_string3`;
    io:println(rawTemplate.strings);
    io:println(rawTemplate.insertions);

    // Ensure we have 2 ints followed by a boolean value as interpolations based on insertions type.
    MyCSVRawTemplate myCSVRawTemplate = `fixed_string4, ${col1}, ${col2}, fixed_string_5, ${col3()}`;
    io:println(myCSVRawTemplate.strings);
    io:println(myCSVRawTemplate.insertions);
}
