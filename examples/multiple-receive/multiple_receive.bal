import ballerina/io;
import ballerina/lang.runtime;

type Result record {
    int w1;
    int w2;
};

public function main() {
    worker w1 {
        2 -> w3;
    }

    worker w2 {
        runtime:sleep(2);
        3 -> w3;
    }

    worker w3 returns Result {
        // The worker waits until both values are received.
        Result result = <- {w1, w2};
        return result;
    }

    Result result = wait w3;
    io:println(result.w1);
    io:println(result.w2);
}
