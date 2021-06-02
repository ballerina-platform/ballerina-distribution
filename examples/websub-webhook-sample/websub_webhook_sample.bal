// The Ballerina WebSub Subscriber service, which could be used as a WebHook Listener for GitHub.
import ballerina/websub;
import ballerina/io;

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
service /subscriber on new websub:Listener(9090) {
    // Defines the remote function that accepts the event notification request for the WebHook.
    remote function onEventNotification(
                    websub:ContentDistributionMessage event) returns error? {
        var retrievedContent = event.content;
        if (retrievedContent is json) {
            if (retrievedContent.zen is string) {
                int hookId = check retrievedContent.hook_id;
                int senderId = check retrievedContent.sender.id;
                io:println(string`PingEvent received for webhook [${hookId}]`);
                io:println(string`Event sender [${senderId}]`);
            } else if (retrievedContent.ref is string) {
                string repositoryName = 
                            check retrievedContent.repository.name;
                string lastUpdatedTime = 
                            check retrievedContent.repository.updated_at;
                io:println(string`PushEvent received for [${repositoryName}]`);
                io:println(string`Last updated at ${lastUpdatedTime}`);
            }
        } else {
            io:println("Unrecognized content type, hence ignoring");
        }
    }
}
