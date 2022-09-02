import ballerina/io;

public function main() {
    worker A {
        int msg = 10;

        // Synchronous send to worker `B`. Worker 'A' will wait until 'B' receives the message.
        error? res = msg ->> B;
        io:println(res ?: "Transmission to B is successful");

        // This transmission will not happen instead returns `error`.
        res = msg + 10 ->> B;
        io:println(res ?: "Transmission to B is successful");
    }

    worker B returns error? {
        int receivedMsg;

        receivedMsg = <- A;
        io:println(string `Received ${receivedMsg} from worker A`);

        if receivedMsg == 10 {
            return error("Error in worker B");
        }

        receivedMsg = <- A;
        io:println(string `Received ${receivedMsg} from worker A`);
    }
}
