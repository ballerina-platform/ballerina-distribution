import ballerina/http;
import ballerina/io;
import ballerina/lang.runtime;

public function main() {
    worker w1 {
        map<json>|error result = fetch("https://postman-echo.com/get?worker=w1");
        result -> w3;
    }

    worker w2 {
        runtime:sleep(3);
        map<json>|error result = fetch("https://postman-echo.com/get?worker=w2");
        result -> w3;
    }

    worker w3 returns json|error? {
        // The value of the variable `result` is set as soon as the value from either
        // worker `w1` or `w2` is received.
        map<json>|error result = <- w1 | w2;
        return getJsonProperty(result);
    }

    worker w4 returns error? {
        // invalid url
        map<json>|error result = fetch("https://postman-echo.com/ge?worker=w4");
        result -> w6;
    }

    worker w5 returns error? {
        runtime:sleep(2);
        map<json>|error result = fetch("https://postman-echo.com/get?worker=w5");
        result -> w6;
    }

    worker w6 returns json|error? {
        // Alternate receive action waits until a message that is not an error is received. 
        // Since `w3` returns an error, it waits further and sets the value that is received from `w4`.
        map<json>|error result = <- w4 | w5;
        return getJsonProperty(result);
    }

    json|error? w3Result = wait w3;
    io:println(w3Result);

    json|error? w6Result = wait w6;
    io:println(w6Result);
}

function fetch(string url) returns map<json>|error {
    http:Client cl = check new (url);
    record {map<json> args;} payload = check cl->get("");
    return payload.args;
}

function getJsonProperty(map<json>|error data) returns json|error =>
    data is error ? data.message() : data.'worker;
