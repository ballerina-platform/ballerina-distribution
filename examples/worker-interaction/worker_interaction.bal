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
        // Receives a message from the worker `w2`.
        int w2val = check <- w2;
        io:println("Result from w2: ", w2val);
    }
    // A worker can return a specific value of a type or return () if 
    // a return type is not mentioned. 
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
        io:println("Result from w1: ", w1val);
        // Sends a message asynchronously to the worker `w1`.
        w1val + w2val -> w1;
    }
    // Waits for the worker `w1`to finish.
    check wait w1;
}

function calculate(string expr) returns int|error {
    http:Client httpClient = new ("https://api.mathjs.org");
    var response = check httpClient->get(string `/v4/?expr=${expr}`);
    return check 'int:fromString(check <@untainted> response.getTextPayload());
}