import ballerina/http;
import ballerina/lang.runtime;

// Define the failover client endpoint to call the backend services.
http:FailoverClient foBackendEP = check new ({

    timeout: 5,
    failoverCodes: [501, 502, 503],
    interval: 5,
    // Define a set of HTTP Clients that are targeted for failover.
    targets: [
            {url: "http://nonexistentEP/mock1"},
            {url: "http://localhost:8080/echo"},
            {url: "http://localhost:8080/mock"}
        ]
});

service / on new http:Listener(9090) {
    resource function 'default fo() returns string|error {
        string payload = check foBackendEP->get("/");
        return payload;
    }
}

// Define the sample service to mock connection timeouts and service outages.
service / on new http:Listener(8080) {
    resource function 'default echo() returns string {

        // Delay the response for 30 seconds to mimic network level delays.
        runtime:sleep(30);
        return "echo Resource is invoked";
    }

    // Define the sample resource to mock a healthy service.
    resource function 'default mock() returns string {
        return "Mock Resource is Invoked.";
    }
}
