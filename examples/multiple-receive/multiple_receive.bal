import ballerina/http;
import ballerina/io;
import ballerina/lang.runtime;

type Response record {
    record {
        string 'worker;
    } args;
};

type Result record {
    string|error a;
    string|error b;
};

function fetch(string workerParam) returns string|error {
    http:Client cl = check new ("https://postman-echo.com");
    Response response = check cl->/get('worker = workerParam);
    return response.args.'worker;
}

public function main() {
    // Workers `w1` and `w2` call the `fetch` function to retrieve content. The workers 
    // send the result of calling the `fetch` function to the default worker.
    worker w1 {
        fetch("w1") -> function;
    }

    worker w2 {
        runtime:sleep(2);
        fetch("w2") -> function;
    }

    // The multiple receive action is used to receive values from both workers.
    Result result = <- {a: w1, b: w2};
    io:println(result);
}
