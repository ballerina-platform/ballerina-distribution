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

    // Any value is allowed as an interpolation when defining a value of the `object:RawTemplate` type 
    // since it has `(any|error)[]` as the `insertions` type.
    object:RawTemplate rawTemplate = `${col1}, fixed_string1,  ${col2}, ${col3()}, fixed_string3`;
    io:println(rawTemplate.strings);
    io:println(rawTemplate.insertions);

    // With the custom `MyCSVRawTemplate ` raw template type, the compiler 
    // expects two integers followed by a boolean value as interpolations.
    MyCSVRawTemplate myCSVRawTemplate = `fixed_string4, ${col1}, ${col2}, fixed_string_5, ${col3()}`;
    io:println(myCSVRawTemplate.strings);
    io:println(myCSVRawTemplate.insertions);
}
