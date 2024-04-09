import ballerina/io;

function getIndex(int[] values, int value) returns int|error {
    int? index = values.indexOf(value);
    if index is () {
        return error("value not found");
    } 
    
    return index;
}

public function main() {
    int[] values = [2, 3, 4, 5];
    int value = 0;

    worker w1 {
        int index = check getIndex(values, value);
        index -> w2;
    } on fail {
        // Handle the error thrown in the worker body
        -1 -> w2;
    }

    worker w2 returns int|error:NoMessage {
        int|error:NoMessage result = <- w1 | w1;
        return result;
    }

    int|error:NoMessage result = wait w2;
    io:println(result);
}
