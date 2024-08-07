import ballerina/http;
import ballerina/io;
import ballerina/lang.runtime;

type Result record {
    json|error a;
    json|error b;
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

function fetch(string url) returns json|error {
    http:Client cl = check new (url);
    record {map<json> args;} payload = check cl->get("");
    return payload.args.'worker;
}
