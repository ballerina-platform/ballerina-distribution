import ballerina/io;

public function main() {

    string[] names = ["Bob", "Jo", "Ann", "Tom"];
    int i = 0;
    while true {
        io:println(names[i]);
        // loop breaks when condition satisfied
        if names[i] == "Tom" {
            break;
        }

        i += 1;
    }

    foreach string name in names {
        // loop breaks when condition satisfied
        if name == "Ann" {
            break;
        }

        io:println(name);
    }
}
