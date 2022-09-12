import ballerina/io;

public function main() {
    worker A {
        int msg = 10;
        msg -> B;

        // This transmission will not happen.
        "Hello" -> B;
        
        // Flush all messages sent to worker 'B'. 
        // Worker 'A' will stop here until all messages are sent or until a failure occurs in 'B'.
        error? result = trap flush B;
        
        // This will return the `panic` error.
        io:println("Result from worker B : ", result ?: "nil");
    }

    worker B {
        int value;

        value = <- A;
        io:println(string `Received integer ${value} from worker A`);

        if value == 10 {
            panic error("Error in worker B");
        }

        string text = <- A;
        io:println(string `Received string "${text}" from worker A`);
    }
}
