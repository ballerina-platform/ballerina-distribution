import ballerina/http;
import ballerina/io;
import ballerina/lang.'int;

public function main() {
    // Call the 'calculate' function asynchronously.
    future<int> f1 = start calculate("365*24");
    // Do some other processing.
    int secondsInHour = 60 * 60;
    // Wait for the future to finish and extract the result
    int hoursInYear = wait f1;
    int secondsInYear = hoursInYear * secondsInHour;
    io:println("Seconds in an year = ", secondsInYear);

    future<int> f2 = start calculate("125*34");
    future<int> f3 = start multiply(125, 34);
    // Wait for any of the given futures to complete. The first future that is completed will return the result.
    int result1 = wait f2|f3;
    io:println("125*34 = ", result1);

    future<int> f4 = start calculate("9*8*7*6");
    future<int> f5 = start calculate("5*4*3*2*1");
    // Wait for all the given futures to complete. The result of the `wait` action can be assigned to a map or a record. 
    record { int r1; int r2; } result2 = wait {r1: f4, r2: f5};
    io:println("9! = ", result2.r1 * result2.r2);
}

function calculate(string expr) returns int {
    http:Client httpClient = new ("https://api.mathjs.org");
    string response = <string> checkpanic
        httpClient->get(string `/v4/?expr=${expr}`, targetType = string);
    return checkpanic 'int:fromString(<@untainted>response);
}

function multiply(int a, int b) returns int {
    return a * b;
}
