import ballerina/http;
import ballerina/io;
import ballerina/lang.runtime;

type Response record {
    record {
        string 'worker;
    } args;
};

// Concurrently fetch content from two URLs using workers `w1` and `w2` and
// return the first non-error value received by worker `w3` from either `w1` or `w2`.
function getFirstFetched(string url1, string url2) returns string? {
    // Workers `w1` and `w2` fetch content from `url1` and `url2` respectively.
    worker w1 {
        string|error result = fetch(url1);
        result -> w3;
    }

    worker w2 {
        runtime:sleep(3);
        string|error result = fetch(url2);
        result -> w3;
    }

    // Worker `w3` waits until one of workers return a non-error value. 
    worker w3 returns string? {
        // The value of the variable `result` is set as soon as
        // a non-error message is received from either worker `w1` or `w2`.
        string|error result = <- w1 | w2;
        return result is error ? () : result;
    }

    // The value returned from worker `w3` is set to the variable `w3Result`.
    string? w3Result = wait w3;
    return w3Result;
}

function fetch(string url) returns string|error {
    http:Client cl = check new (url);
    Response response = check cl->get("");
    return response.args.'worker;
}

public function main() {
    // Both arguments passed to the `getFirstFetched` function are valid URLs.
    // Thus, the alternate receive action in worker `w3` sets the
    // first value it receives from a worker as the result.
    string? firstFetched = getFirstFetched("https://postman-echo.com/get?worker=w1",
            "https://postman-echo.com/get?worker=w2");
    io:println(firstFetched);

    // The first argument passed to the `getFirstFetched` function is an invalid URL.
    // Therefore, the worker `w1` in the `getFirstFetched` function returns an error.
    // Thus, the alternate receive action in worker `w3` waits further
    // and sets the value that is received from `w2` as the result.
    firstFetched = getFirstFetched("https://postman-echo.com/ge?worker=w4",
            "https://postman-echo.com/get?worker=w5");
    io:println(firstFetched);
}
