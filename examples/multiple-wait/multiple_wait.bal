import ballerina/http;
import ballerina/io;

type Result record {
    string|error a;
    string|error b;
};

function multiFetch(string urlA, string urlB) returns Result {
    worker WA returns string|error {
        return fetch(urlA);
    }
    worker WB returns string|error {
        return fetch(urlB);
    }

    // The `wait` action can be used to wait for multiple named workers.
    return wait {a: WA, b: WB};
}

public function main() returns error? {
    Result res = multiFetch("https://postman-echo.com/get?lang=ballerina",
                            "https://postman-echo.com/get?greeting=hello");
    io:println(res);
    return;
}

function fetch(string url) returns string|error {
    http:Client cl = check new (url);
    map<json> payload = check cl->get("");
    return payload["args"].toString();
}
