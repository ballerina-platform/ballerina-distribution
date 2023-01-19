import ballerina/io;

public function main() {
    foreach int i in 0...5 {
        if (i == 2) {
            // A `continue` statement can be used to skip the current iteration.
            continue;
        }

        io:println(i);
    }

    int i = 0;
    while i <= 5 {
        if i == 2 {
            i = i + 1;
            // A `continue` statement can be used to skip the current iteration.
            continue;
        }

        io:println(i);
        i = i + 1;
    }
}
