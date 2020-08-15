import ballerina/http;
import ballerina/lang.'int;
import ballerina/io;

// Workers interact with each other by sending and receiving messages.
// Ballerina validates every worker interaction (send and receive)
// to avoid deadlocks.
public function main() returns error? {
    worker w1 returns error? {
        int|error result = calculate("2*3");
        int w1val;
        if result is error { return result; }
        else { w1val = result; }
        // Sends a message asynchronously to the worker `w2`.
        w1val -> w2;
        int w2val;
        // Receives a message from the worker `w2`.
        int|error recv = <- w2;
        if recv is error { return recv; }
        else { w2val = recv; }
        io:println("[w1] Message from w2: ", w2val);
        // Sends messages synchronously to the worker `w3`. The worker `w1` will wait
        // until the worker `w3` receives the message.
        w1val ->> w3;
        w2val -> w3;
        // Flushes all messages sent asynchronously to the worker `w3`. The worker
        // will halt at this point until all messages are sent or until the worker `w3`
        // fails.
        check flush w3;
    }
    // A worker can have an explicit return type, or else, if a return type is not mentioned,
    // it is equivalent to returning ().
    worker w2 returns error? {
        int|error result = calculate("17*5");
        int w2val;
        if result is error { return result; }
        else { w2val = result; }
        int w1val;
        // Receives a message from the worker `w1`.
        int|error recv = <- w1;
        if recv is error { return recv; }
        else { w1val = recv; }
        io:println("[w2] Message from w1: ", w1val);
        // Sends a message asynchronously to the worker `w1`.
        w1val + w2val -> w1;
    }
    worker w3 {
        int|error w1val = <- w1;
        int|error w2val = <- w1;
        io:println("[w3] Messages from w1: ", w1val, ", ", w2val);
    }
    // Waits for the worker `w1`to finish.
    check wait w1;
}

function calculate(string expr) returns int|error {
    http:Client httpClient = new ("https://api.mathjs.org");
    var response = check httpClient->get(string `/v4/?expr=${expr}`);
    return check 'int:fromString(check <@untainted> response.getTextPayload());
}