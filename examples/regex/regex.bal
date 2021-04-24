import ballerina/io;
import ballerina/regex;

public function main() {

    // Checks whether the given string matches the provided regex.
    // You need to provide the original `string` and the regex to
    // which this string is to be matched.
    boolean isMatched = regex:matches("This Should Match", "Th.*ch");
    io:println("Is this matched: ", isMatched);

    // Replaces each occurrence of the substrings, which match the provided
    // regular expression from the given original string value with the
    // provided replacement string.
    string new_string = regex:replaceAll("Ballerina is great", "\\s+", "_");
    io:println("Replaced string: ", new_string);

    // Replaces the first substring that matches the given regular expression
    // with the provided `replacement` string.
    new_string = regex:replaceFirst("ReplacethisthisTextThis", "this", " ");
    io:println("String after replacing first Match: ", new_string);

    // Retrieve an array of strings by splitting a string using the provided
    // delimiter.
    string[] names = regex:split("amal, kamal, nimal, sunimal", ",");
    io:println("No of names: ", names.length());
}