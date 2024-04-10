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
        // Since the send action is within a conditional context and 
        // there is a possibility that the send action may not be executed,
        // error:NoMessage type is added.
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
        // Since send action is used in two instances within worker `w3`
        // an alternate receive action is used here.
        int|error:NoMessage d = <- w3 | w3;
        return d;
    }

    int|error:NoMessage w2Result = wait w2;
    io:println(w2Result);

    int|error:NoMessage w4Result = wait w4;
    io:println(w4Result);
}
