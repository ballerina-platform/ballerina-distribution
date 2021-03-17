import ballerina/io;
import ballerina/http;

// The code outside the named workers belongs to an implicit 
// default worker. The default worker in each function wil be 
// executed in the same strand as the caller function.
public function main() returns error? {
    io:println("Worker execution started");

    // This block belongs to the `w1` worker.
    worker w1 returns error? {
        http:Client httpClient = check new ("https://api.mathjs.org");
        string response = <string> check httpClient->get("/v4/?expr=2*3",
                                                         targetType = string);
        io:println("Worker 1 response: ", response);
    }

    worker w2 returns error? {
        http:Client httpClient = check new ("https://api.mathjs.org");
        string response = <string> check httpClient->get("/v4/?expr=5*7",
                                                         targetType = string);
        io:println("Worker 2 response: ", response);
    }

    // Wait for both workers to finish.
    record{error? w1; error? w2;} result = wait {w1, w2};

    io:println("Worker execution finished: ", result);
}
