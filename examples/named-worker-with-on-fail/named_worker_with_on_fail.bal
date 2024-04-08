import ballerina/io;

public function main() {
    int[] vals = [2, 3, 4, 5];
    int key = 1;
    int val = 0;

    worker w1 {
        int? index = vals.indexOf(key);
        if index != () {
            val = vals[index];
        } else {
            check error("value not found");
        }
        val -> w2;
    } on fail {
        // handle the error thrown in the worker body
        -1 -> w2;
    }

    worker w2 returns int|error:NoMessage {
        int|error:NoMessage result = <- w1 | w1;
        return result;
    }

    int|error:NoMessage result = wait w2;
    io:println(result);
}
