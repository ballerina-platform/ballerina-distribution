import ballerina/io;

public function main() {
    string:RegExp pat1 = re `a+`;
    string a0 = "";
    io:println(pat1.isFullMatch(a0));
    string a1 = "a";
    io:println(pat1.isFullMatch(a1));
    string a2 = "aa";
    io:println(pat1.isFullMatch(a2));

    string:RegExp pat2 = re `[a-z]+`;
    string b = "bb";
    io:println(pat2.isFullMatch(b));
    string b1 = "bb1";
    io:println(pat2.isFullMatch(b1));
}
