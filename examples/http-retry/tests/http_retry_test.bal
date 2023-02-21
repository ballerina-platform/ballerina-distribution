import ballerina/http;
import ballerina/lang.runtime;
import ballerina/log;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client backendClientEP = check new ("localhost:8080",
        retryConfig = {
            interval: 3,
            count: 3,
            backOffFactor: 2.0,
            maxWaitInterval: 20
        },
        timeout = 2
    );
    string payload = check backendClientEP->/greeting;
    test:assertEquals(payload, "Hello World!!!");
}

service / on new http:Listener(8080) {
    private int counter = 0;
    resource function get greeting() returns string {
        self.counter += 1;
        // Delay the response by 5 seconds to mimic network-level delays.
        if self.counter % 4 != 0 {
            log:printInfo("Request received from the client to delayed service.");
            runtime:sleep(5);
            return "Hello World!!!";
        } else {
            log:printInfo("Request received from the client to healthy service.");
            return "Hello World!!!";
        }
    }
}
