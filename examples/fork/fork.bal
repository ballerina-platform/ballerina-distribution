import ballerina/io;
import ballerina/lang.runtime;

public function main() {
    execute(true);
    runtime:sleep(1);
    execute(false);
}

function execute(boolean isForked) {
    if isForked {
        fork {
            worker A {
                5 -> B;
                string value = <- B;
                io:println(string `Received string '${value}' from worker B`);
            }

            worker B {
                int value = <- A;
                io:println(string `Received int '${value}' from worker A`);
                "a" -> A;
            }
        }
    } else {
        io:println("Not forked");
    }
}
