import ballerina/io;

public function main() {

    // Loop through a list
    string[] names = ["Bob", "Jo", "Ann", "Tom"];
    int i = 0;
    while i < names.length() {
        io:println(names[i]);
        i += 1;
    }
}
