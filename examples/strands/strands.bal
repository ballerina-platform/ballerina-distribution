import ballerina/io;

public function main() {
    // By default, named workers are multitasked cooperatively, not preemptively.
    // Each named worker has a `strand` (a logical thread of control) and 
    // the execution switches between strands only at specific `yield` points.
    worker A {
        io:println("In worker A");
    }

    // An annotation can be used to make a strand run on a separate thread.
    @strand {
        thread: "any"
    }

    worker B {
        io:println("In worker B");
    }

    io:println("In function worker");
}
