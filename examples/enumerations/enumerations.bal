import ballerina/io;

// This is shorthand for,
//
// `const RED = "RED";`
//
// `const GREEN = "GREEN";`
//
// `const BLUE = "BLUE";`
//
// `type Color RED|GREEN|BLUE;`
enum Color {
    RED,
    GREEN,
    BLUE
}

// An `enum` member can explicitly specify an associated expression.
enum Language {
    ENG = "English",
    TL = "Tamil",
    SI = "Sinhala"
}

public function main() {
    io:println(RED);
    io:println(ENG);
}
