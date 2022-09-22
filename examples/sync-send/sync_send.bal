import ballerina/io;

public function main() {
    worker A {
        int msg = 10;

        // Send a message synchronously to the `B` worker.
        // The 'A' worker will wait until 'B' receives the message.
        error? res = msg ->> B;
        io:println(res ?: "Transmission to B is successful");

        // This transmission will not happen. Instead, it returns an `error`.
        res = "Hello" ->> B;
        io:println(res ?: "Transmission to B is successful");
    }

    worker B returns error? {
        int value;

        value = <- A;
        io:println(string `Received ${value} from the A worker.`);

        if value == 10 {
            return error("Error in the B worker.");
        }

        string text = <- A;
        io:println(string `Received ${text} from the A worker.`);
    }
}
