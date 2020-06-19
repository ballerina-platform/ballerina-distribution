import ballerina/io;

// An enum is defined using a module enum declaration.
enum Color {
  RED,
  GREEN,
  BLUE
}

enum Language {
    // An enum member can explicitly specify an associated
    // expression.
    ENG = "English",
    TL = "Tamil",
    SI = "Sinhala"
}

// An enum declaration can consist of a combination of members with or without
// explicit associated values.
enum Bands {
    QUEEN,
    PF = "Pink " + "Floyd"
}

public function main() {
    // An enum member can be used in the same way as a string constant.
    string skyColor = BLUE;
    io:println("skyColor: ", skyColor);

    string joined = takeStrings(QUEEN, PF);
    io:println("joined: ", joined);

    // An enum can also be used as a type.
    Language language = getLanguage("e");
    io:println("language: ", language);

    Language sinhala = "Sinhala";
    io:println("sinhala: ", sinhala);

    ENG english = "English";
    io:println("english: ", english);
}

function takeStrings(string str1, string str2) returns string {
    return str1 + " and " + str2;
}

function getLanguage(string symbol) returns Language {
    if (symbol == "e") {
        return ENG;
    } else if (symbol == "t") {
        return TL;
    }
    return SI;
}
