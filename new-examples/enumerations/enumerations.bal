import ballerina/io;

// This is shorthand for <br></br>
// `const RED = "RED";` <br></br>
// `const GREEN = "GREEN";` <br></br>
// `const BLUE = "BLUE":` <br></br>
// `type Color RED|GREEN|BLUE;`
enum Color {
    RED, GREEN, BLUE
}

enum Language {
    ENG = "English",
    TL = "Tamil",
    SI = "Sinhala"
}

public function main() {
    io:println(RED);
    io:println(ENG);
}
