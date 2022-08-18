import ballerina/io;

public function main() {
    // A variable of type `string:Char` to which only strings of  
    // length 1 can be assigned.
    string:Char ch = "x";
    io:println(ch);
    
    // The `lang.string:toCodePoint` lang library function can be used with 
    // an expression of the `string:Char` type to retrieve the relevant code point value.
    int cp = ch.toCodePointInt();
    io:println(cp);
}
