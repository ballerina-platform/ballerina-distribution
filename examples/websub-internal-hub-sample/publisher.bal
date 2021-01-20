// The Ballerina WebSub Publisher brings up the internal Ballerina hub, registers a topic at the hub, and publishes updates to the topic.
import ballerina/http;
import ballerina/io;
import ballerina/runtime;
import ballerina/websubhub;

public function main() {

    // Specifies the port that the internal Ballerina hub needs to start on and start the hub.
    io:println("Starting up the Ballerina Hub Service");

    websubhub:Hub webSubHub;
    var result = websubhub:startHub(new http:Listener(9191), "/websub", "/hub");
    if (result is websubhub:Hub) {
        webSubHub = result;
    } else if (result is websubhub:HubStartedUpError) {
        webSubHub = result.startedUpHub;
    } else {
        io:println("Hub start error:" + result.message());
        return;
    }

    // Registers a topic at the hub using [registerTopic](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/websub/classes/Hub#registerTopic).
    var registrationResponse = webSubHub.registerTopic(
                                            "http://websubpubtopic.com");
    if (registrationResponse is error) {
        io:println("Error occurred registering topic: " +
                                registrationResponse.message());
    } else {
        io:println("Topic registration successful!");
    }

    // Makes the publisher wait until the subscriber subscribes at the hub.
    runtime:sleep(5000);

    // Publishes directly to the internal Ballerina hub using [publishUpdate](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/websub/classes/Hub#publishUpdate).
    io:println("Publishing update to internal Hub");
    var publishResponse = webSubHub.publishUpdate("http://websubpubtopic.com",
        {"action": "publish", "mode": "internal-hub"});

    if (publishResponse is error) {
        io:println("Error notifying hub: " +
                                publishResponse.message());
    } else {
        io:println("Update notification successful!");
    }

    // Keeps the service is running until the subscriber receives the update notification.
    runtime:sleep(2000);
}
