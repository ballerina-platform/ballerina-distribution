import ballerina/http;
import ballerina/io;
import ballerina/lang.runtime;

type Response record {
    record {string 'worker;} args;
};

type Result record {
    string|error a;
    string|error b;
};

public function main() {
    worker w1 {
        fetch("https://postman-echo.com/get?worker=w1") -> function;
    }

    worker w2 {
        runtime:sleep(2);
        fetch("https://postman-echo.com/get?worker=w2") -> function;
    }

    // The worker waits until both values are received.
    Result result = <- {a: w1, b: w2};
    io:println(result);
}

function fetch(string url) returns string|error {
    http:Client cl = check new (url);
    Response {args: {'worker: 'worker}} = check cl->get("");
    return 'worker;
}
