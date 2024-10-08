import ballerina/io;

public function main() {
    int[] values = [2, 3, 4, 5];
    int value = 0;

    worker w1 {
        int index = check getIndex(values, value);
        index -> function;
    } on fail {
        // Handle the error thrown in the worker body.
        -1 -> function;
    }

    int|error:NoMessage result = <- w1 | w1;
    io:println(result);
}

function getIndex(int[] values, int value) returns int|error =>
    let int? index = values.indexOf(value) in index ?: error("value not found");
