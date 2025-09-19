import ballerina/io;
import ballerina/lang.regexp;

public function main() returns error? {
    
    // Declare a `RegExp` value using a regular expression literal.
    regexp:RegExp alphanumericPattern = re `[a-zA-Z0-9]`;
    // Matches any string that is a single alphanumeric character.
    io:println("Pattern `[a-zA-Z0-9]` matches `a`: ", alphanumericPattern.isFullMatch("a"));

    // `string:RegExp` is an alias for `regexp:RegExp`.
    string:RegExp alphanumericPattern2 = re `[a-zA-Z0-9]`;
    io:println("Pattern `[a-zA-Z0-9]` matches `a1`: ", alphanumericPattern2.isFullMatch("a1"));

    // Construct a `RegExp` value from a string using the `fromString` langlib function.
    string:RegExp pattern = check regexp:fromString("HELLO*");
    // Matches any string that starts with "HELLO" and ends with zero or more characters.
    io:println("Pattern `HELLO*` matches `HELLO`: ", pattern.isFullMatch("HELLO"));

    // Matches any string that contains one or more consecutive "a" characters.
    boolean result = re `a+`.isFullMatch("aaa");
    io:println("Pattern `a+` matches `aaa`: ", result);

    // Interpolations can be used to construct the pattern dynamically.
    string literal = "xyz";
    string:RegExp pattern2 = re `abc|${literal}`;
    // Matches any string that starts with "abc" or "XYZ".
    io:println("Pattern `abc|${\"xyz\"}` matches `xyz`: ", pattern2.isFullMatch("xyz"));

    // The `RegExp` type supports Unicode general category patterns.
    // Characters are matched based on their Unicode properties.
    string:RegExp pattern3 = re `\p{Ll}`;
    io:println("Pattern `\\p{Ll}` matches `a`: ", "a".matches(pattern3));

    // The `\P` escape sequence is used to get the negation of the pattern.
    // Matches every non-puncutation character.
    string:RegExp pattern4 = re `\P{P}`;
    io:println("Pattern `\\p{P}` matches `0`: ", "0".matches(pattern4));

    // The `RegExp` type supports matching characters according to the script using Unicode script patterns.
    string:RegExp pattern5 = re `\p{sc=Latin}`;
    regexp:Span? findResult = pattern5.find("aεЛ");
    // The `find` function returns nil if no match is found. Since we know a 
    // match is found here, use the `ensureType` function to narrow the type down to `regexp:Span`.
    regexp:Span latinValue = check findResult.ensureType();
    io:println("Pattern `\\p{sc=Latin}` matches `aεЛ`: ", latinValue.substring());

    // The `RegExp` type supports non-capturing groups to control the behavior of regular expression patterns.
    // The `i` flag will ignore the case of the pattern.
    string:RegExp pattern6 = re `(?i:BalleRINA)`;
    io:println("Pattern `(?i:BalleRINA)` matches `Ballerina`: ", "Ballerina".matches(pattern6));
}
