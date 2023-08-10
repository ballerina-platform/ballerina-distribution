import ballerina/io;

public function main() {
    foreach int i in 0...9 {
        // Loop breaks when the condition is satisfied.
        if (i > 5) {
            break;
        }

        io:println(i);
    }

    int i = 0;
    while true {
        // Loop breaks when the condition is satisfied.
        if i > 5 {
            break;
        }

        io:println(i);
        i = i + 1;
    }
}
