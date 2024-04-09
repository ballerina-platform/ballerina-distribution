import ballerina/io;

public function main(int? userInput) {
    if userInput is int {
        int num = userInput;
        fork {
            worker A {
                num -> B;
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
