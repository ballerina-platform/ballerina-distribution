import ballerina/io;

public function main() {
    worker A {
        int num = 10;

        // Sends the `10` integer value to the `B` worker asynchronously.
        num -> B;
        
        // Receives the `Hello` string from the `B` worker.
        string msg = <- B;
        io:println(string `Received string "${msg}" from worker B`);
    }

    worker B {
        int num;

        // Receives the `10` integer value from the `A` worker.
        num = <- A;
        io:println(string `Received integer "${num}" from worker A`);

        // Sends the `Hello` string to the `A` worker asynchronously.
        string msg = "Hello";
        msg -> A;
    }
}
