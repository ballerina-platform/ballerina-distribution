import ballerina/io;

public function main() {
    boolean foo = true;

    worker w1 {
        // send action can be used in a conditional context.
        if foo {
            10 -> w2;
        }
    }

    worker w2 returns int|error:NoMessage {
        int|error:NoMessage a = <- w1;
        return a;
    }

    worker w3 {
        if foo {
            1 -> w4;
        } else {
            0 -> w4;
        }
    }

    worker w4 returns int|error:NoMessage {
        int|error:NoMessage d = <- w3 | w3;
        return d;
    }

    int|error:NoMessage w2Val = wait w2;
    int|error:NoMessage w4Val = wait w4;

    io:println(w2Val);
    io:println(w4Val);
}
