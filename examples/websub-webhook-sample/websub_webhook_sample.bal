// The Ballerina WebSub Subscriber service, which could be used as a WebHook Listener for GitHub.
import ballerina/io;
import ballerina/websub;

// Annotation-based configurations specifying the subscription parameters.
@websub:SubscriberServiceConfig {
    target: [
        "https://api.github.com/hub", 
        "https://github.com/<YOUR_ORGANIZATION>/<REPOSITORY>/events/push.json"
    ],
    secret: "<YOUR_SECRET_KEY>",
    httpConfig: {
        auth: {
            token: "<YOUR_AUTH_TOKEN>"
        }
    }
}
service on new websub:Listener(9090) {
    // Defines the remote function that accepts the event notification request for the WebHook.
    remote function onEventNotification(websub:ContentDistributionMessage event) returns error? {
        json retrievedContent = check event.content.ensureType();
        if retrievedContent.zen is string {
            int hookId = check retrievedContent.hook_id;
            io:println(string `PingEvent received for webhook [${hookId}]`);
            int senderId = check retrievedContent.sender.id;
            io:println(string `Event sender [${senderId}]`);
        } else if retrievedContent.ref is string {
            string repositoryName = check retrievedContent.repository.name;
            io:println(string `PushEvent received for [${repositoryName}]`);
            string lastUpdatedTime = check retrievedContent.repository.updated_at;
            io:println(string `Last updated at ${lastUpdatedTime}`);
        }
    }
}
