import ballerina/test;
import ballerina/http;

import ballerina/lang.runtime;

@test:Config {}
function testFunc() returns error? {
    http:FailoverClient httpEndpoint = check new ({

        timeout: 5,
        failoverCodes: [501, 502, 503],
        interval: 5,
        targets: [
                {url: "http://nonexistentEP/mock1"},
                {url: "http://localhost:8080/echo"},
                {url: "http://localhost:8080/mock"}
            ]
    });

    string response = check httpEndpoint->/greeting;
    test:assertEquals(response, "The mock resource is invoked.");
}

// Define the sample service to mock connection timeouts and service outages.
service / on new http:Listener(8080) {
    resource function 'default echo/greeting() returns string {

        // Delay the response for 30 seconds to mimic network level delays.
        runtime:sleep(30);
        return "The echo resource is invoked";
    }

    // Define the sample resource to mock a healthy service.
    resource function 'default mock/greeting() returns string {
        return "The mock resource is invoked.";
    }
}
