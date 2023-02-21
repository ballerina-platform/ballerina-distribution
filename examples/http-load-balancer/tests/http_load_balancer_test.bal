import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns error? {
    http:LoadBalanceClient httpEndpoint = check new ({
        targets: [
            {url: "http://localhost:8080/mock1"},
            {url: "http://localhost:8080/mock2"},
            {url: "http://localhost:8080/mock3"}
        ],
        timeout: 5
    });

    string response = check httpEndpoint->/greeting;
    test:assertEquals(response, "Mock1 resource was invoked.");

    response = check httpEndpoint->/greeting;
    test:assertEquals(response, "Mock2 resource was invoked.");

    response = check httpEndpoint->/greeting;
    test:assertEquals(response, "Mock3 resource was invoked.");

    response = check httpEndpoint->/greeting;
    test:assertEquals(response, "Mock1 resource was invoked.");
}

service / on new http:Listener(8080) {
    resource function get mock1/greeting() returns string {
        return "Mock1 resource was invoked.";
    }

    resource function get mock2/greeting() returns string {
        return "Mock2 resource was invoked.";
    }

    resource function get mock3/greeting() returns string {
        return "Mock3 resource was invoked.";
    }
}
