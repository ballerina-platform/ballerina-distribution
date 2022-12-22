import ballerina/io;

public function main() {

    // Loop through a list
    string[] names = ["Bob", "Jo", "Ann", "Tom"];
    int i = 0;
    while i < names.length() {
        if names[i] == "Ann" {
            i += 1;
            // ‘continue’ statement can be used to skip the current iteration
            continue;
        }

        io:println(names[i]);
        i += 1;
    }

    // Loop through a list
    foreach string name in names {
        if name == "Ann" {
            continue;
        }

        io:println(name);
    }
}
