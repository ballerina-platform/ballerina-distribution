import ballerina/io;

public function main() {
    worker A {
        int msg = 10;
        msg -> B;

        // This transmission will not happen.
        msg + 10 -> B;
        
        // Flush all messages sent to worker 'B'. 
        // Worker 'A' will stop here until all messages are sent or until a failure occurs in 'B'.
        error? result = trap flush B;
        
        // This will return the `panic` error.
        io:println("Result from worker B : ", result ?: "nil");

        msg -> B;
    }

    worker B {
        int receivedMsg;

        receivedMsg = <- A;
        io:println(string `Received ${receivedMsg} from worker A`);

        if receivedMsg == 10 {
            panic error("Error in worker B");
        }

        receivedMsg = <- A;
        io:println(string `Received ${receivedMsg} from worker A`);

        receivedMsg = <- A;
        io:println(string `Received ${receivedMsg} from worker A`);
    }
}
