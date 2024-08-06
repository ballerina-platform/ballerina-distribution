import ballerina/http;
import ballerina/io;
import ballerina/lang.runtime;

public function main() {
    alternateReceiveDemo("https://postman-echo.com/get?worker=w1", "https://postman-echo.com/get?worker=w2");

    // Since the first parameter passed to the function is an invalid URL
    // the worker `w1` in alternateReceive function returns an error.
    // Thus alternate receive in worker `w3` waits further and sets
    // the value that is received from `w2` as the result.
    alternateReceiveDemo("https://postman-echo.com/ge?worker=w4", "https://postman-echo.com/get?worker=w5");
}

function alternateReceiveDemo(string url1, string url2) {
    worker w1 {
        map<json>|error result = fetch(url1);
        result -> w3;
    }

    worker w2 {
        runtime:sleep(3);
        map<json>|error result = fetch(url2);
        result -> w3;
    }

    worker w3 returns json|error? {
        // The value of the variable `result` is set as soon as
        // a non-error message is received from either worker `w1` or `w2`.
        map<json>|error result = <- w1 | w2;
        return getJsonProperty(result);
    }

    json|error? w3Result = wait w3;
    io:println(w3Result);
}

function fetch(string url) returns map<json>|error {
    http:Client cl = check new (url);
    record {map<json> args;} payload = check cl->get("");
    return payload.args;
}

function getJsonProperty(map<json>|error data) returns json|error =>
    data is error ? data.message() : data.'worker;
