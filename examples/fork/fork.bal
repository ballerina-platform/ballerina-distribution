import ballerina/io;

public function main() {
    fork {
        worker A {
            5 -> B;
            string value =<- B;
            io:println(string `Received string '${value}' from worker B`);
        }

        worker B {
            int value =<- A;
            io:println(string `Received integer '${value}' from worker A`);

            "a" -> A;
        }
    }
}
