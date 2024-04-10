import ballerina/io;

public function main() {
    boolean isDataReady = true;

    worker w1 {
        // A send action can be used in a conditional context.
        if isDataReady {
            10 -> w2;
        }
    }

    worker w2 returns int|error:NoMessage {
        // The send action corresponding to this receive action is conditionally executed.
        // Thus, there is a possibility that the send action may not get executed.
        // Therefore, the static type of the receive includes the `error:NoMessage` type
        // indicating the absence of a message in such cases.
        int|error:NoMessage a = <- w1;
        return a;
    }

    worker w3 {
        if isDataReady {
            1 -> w4;
        } else {
            0 -> w4;
        }
    }

    worker w4 returns int|error:NoMessage {
        // Two different conditional send actions exists within the worker `w3`.
        // Therefore, an alternate receive action can be used to receive them.
        int|error:NoMessage d = <- w3 | w3;
        return d;
    }

    int|error:NoMessage w2Result = wait w2;
    io:println(w2Result);

    int|error:NoMessage w4Result = wait w4;
    io:println(w4Result);
}
