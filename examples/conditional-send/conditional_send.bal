import ballerina/io;

public function main() {
    boolean isDataReady = true;

    worker w1 {
        // A send action can be used in a conditional context.
        if isDataReady {
            10 -> function;
        }
    }
    worker w2 {
        if isDataReady {
            1 -> function;
        } else {
            0 -> function;
        }
    }

    // The send action corresponding to this receive action is conditionally executed.
    // Thus, there is a possibility that the send action may not get executed.
    // Therefore, the static type of the receive includes the `error:NoMessage` type
    // indicating the absence of a message in such cases.
    int|error:NoMessage w1Message = <- w1;
    io:println(w1Message);

    // Two different conditional send actions exist within the worker `w3`.
    // Therefore, an alternate receive action can be used to receive them.
    int|error:NoMessage w2Message = <- w2 | w2;
    io:println(w2Message);
}
