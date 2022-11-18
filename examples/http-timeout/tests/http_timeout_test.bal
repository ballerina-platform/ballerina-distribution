import ballerina/test;
import ballerina/http;
import ballerina/lang.runtime;

@test:Config {}
function testFunc() returns error? {
    http:Client backendClientEP = check new ("http://localhost:8080", {
        timeout: 10
    });
    string|error response = backendClientEP->get("/greeting");
    if response is error {
        test:assertEquals(response.message(), "Idle timeout triggered before initiating inbound response");
    } else {
        test:assertFail("Unexpected response");
    }
}

service / on new http:Listener(8080) {
    resource function get greeting() returns string {
        runtime:sleep(15);
        return "Hello World!!!";
    }
}
