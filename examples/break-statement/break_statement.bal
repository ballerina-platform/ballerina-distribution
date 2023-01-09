import ballerina/io;

public function main() {
    foreach int i in 0...9 {
        // Loop breaks when condition satisfied.
        if (i > 5) {
            break;
        }

        io:println(i);
    }

    int i = 0;
    while true {
        // Loop breaks when condition satisfied.
        if i > 5 {
            break;
        }

        io:println(i);
        i = i + 1;
    }
}
