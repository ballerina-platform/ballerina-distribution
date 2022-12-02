# WebSub service - Connecting to github as a webhook

Ballerina provides the capability to easily introduce subscriber services that are WebSub-compliant. Ballerina WebSub subscribers can specify the topic and hub to which they wish to subscribe to receive notifications. If not specified WebSub Subscriber Services will auto generate a unique random service path segment. Ballerina WebSub Subscriber Services could thus be registered as WebHooks to receive event notifications. In this example, a WebSub Subscriber service is used to implement a GitHub-based WebHook service.

::: code websub_webhook_sample.bal :::

## Prerequisites
- Internet connectivity to connect to github API.
- An active github repository to receive relevant events. 

Run the subscriber service by executing the following command.

::: out websub_webhook_sample.out :::

## Related links
- [`websub:Listener` object - API documentation](https://lib.ballerina.io/ballerina/websub/latest/listeners/Listener)
- [`websub:SubscriberServiceConfig` annotation - API documentation](https://lib.ballerina.io/ballerina/websub/latest/annotations#SubscriberServiceConfig)
- [`websub:SubscriberService` - specification](https://ballerina.io/spec/websub/#22-subscriber-service)
