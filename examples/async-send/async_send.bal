import ballerina/io;

public function main() {
    worker A {
        int num = 10;

        // Sends integer value `10` to worker `B` asynchronously.
        num -> B;
        
        // Receives string `Hello` from worker `B`.
        string msg = <- B;
        io:println(string `Received string "${msg}" from worker B`);
    }

    worker B {
        int num;

        // Receives integer value `10` from worker `A`.
        num = <- A;
        io:println(string `Received integer "${num}" from worker A`);

        // Sends string `Hello` to worker `A` asynchronously.
        string msg = "Hello";
        msg -> A;
    }
}
