// The Ballerina WebSub Publisher brings up the internal Ballerina Hub,
// registers a topic at the hub, and publishes updates to the topic.
import ballerina/http;
import ballerina/io;
import ballerina/lang.runtime;
import ballerina/websubhub;

public function main() {

    // Starts the internal Ballerina Hub using [startHub](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/ballerina/websub/latest/websub/functions#startHub).
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
    // Registers a topic at the hub using [registerTopic](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/ballerina/websub/latest/websub/classes/Hub#registerTopic).
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

    // Publishes directly to the internal Ballerina Hub using [publishUpdate][publishUpdate](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/ballerina/websub/latest/websub/clients/PublisherClient#publishUpdate)..
    var publishResponse = webSubHub.publishUpdate("http://websubpubtopic.com",
                            {"action": "publish", "mode": "internal-hub"});
    if (publishResponse is error) {
        io:println("Error notifying hub: " + publishResponse.message());
    } else {
        io:println("Update notification successful!");
    }

    // Makes the publisher wait until the subscriber unsubscribes at the hub.
    runtime:sleep(5000);

    // Publishes directly to the internal Ballerina Hub.
    publishResponse = webSubHub.publishUpdate("http://websubpubtopic.com",
                            {"action": "publish", "mode": "internal-hub"});
    if (publishResponse is error) {
        io:println("Error notifying hub: " + publishResponse.message());
    } else {
        io:println("Update notification successful!");
    }

    // Makes the publisher wait until subscribers are notified.
    runtime:sleep(2000);
}
