import ballerina/io;
import ballerina/lang.regexp;

public function main() returns error? {
    
    // Declare a RegExp using regular expression literal.
    string:RegExp _ = re `[a-zA-Z0-9]`;

    // Declare a RegExp using the `fromString` constructor method.
    string:RegExp pattern = check regexp:fromString("HELLO*");
    // Matches any string that starts with "HELLO" and ends with zero or more characters.
    io:println("Pattern `HELLO*` matches `HELLO`: ", pattern.isFullMatch("HELLO"));

    // Matches any string that contains one or more consecutive "a" characters.
    boolean result = re `a+`.isFullMatch("aaa");
    io:println("Pattern `a+` matches `aaa`: ", result);

    // Interpolation can be used to change the pattern dynamically.
    string literal = "xyz";
    string:RegExp pattern2 = re `abc|${literal}`;
    // Matches any string that starts with "abc" or "XYZ".
    io:println("Pattern `abc|${\"xyz\"}` matches `xyz`: ", pattern2.isFullMatch("xyz"));

    // RegExp supports writing Unicode general category patterns. 
    // Characters are matched based on their Unicode properties.
    string:RegExp pattern3 = re `\p{Ll}`;
    io:println("Pattern `\\p{Ll}` matches `a`: ", "a".matches(pattern3));

    // The `\P` escape sequence is used to get the negation of the pattern.
    // This pattern will match every non-puncutation character.
    string:RegExp pattern4 = re `\P{P}`;
    io:println("Pattern `\\p{P}` matches `0`: ", "0".matches(pattern4));

    // RegExp supports matching characters according to the script using Unicode script patterns.
    string:RegExp pattern5 = re `\p{sc=Latin}`;
    regexp:Span? latinValue = pattern5.find("aεЛ");
    io:println("Pattern `\\p{sc=Latin}` matches `aεЛ`: ", (<regexp:Span>latinValue).substring());

    // RegExp supports non-capturing groups to control the behavior of regular expression patterns.
    // The `i` flag will ignore the case of the pattern.
    string:RegExp pattern6 = re `(?i:BalleRINA)`;
    io:println("Pattern `(?i:BalleRINA)` matches `Ballerina`: ", "Ballerina".matches(pattern6));
}
