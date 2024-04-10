import ballerina/io;
import ballerina/lang.runtime;

public function main() {
    worker w1 {
        2 -> w3;
    }

    worker w2 {
        runtime:sleep(2);
        3 -> w3;
    }

    worker w3 returns map<int> {
        // The worker waits until both values are received.
        map<int> result = <- {w1, w2};
        return result;
    }

    map<int> results = wait w3;
    io:println(results["w1"]);
    io:println(results["w2"]);
}
