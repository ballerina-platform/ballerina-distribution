import ballerina/io;

int n = 0;

function inc() {
    // Locks the global variable `n` and increments it by 1.
    lock {
        n += 1;
    }

    io:println(n);
}

public function main() {
    inc();
}
