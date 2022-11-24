# WebSub service - Subscriber

Ballerina provides the capability to easily introduce subscriber services that are WebSub-compliant. Ballerina WebSub subscribers can specify the topic and hub to which they wish to subscribe to receive notifications. If not specified WebSub Subscriber Services will auto generate a unique random service path segment. Ballerina WebSub Subscriber Services could thus be registered as WebHooks to receive event notifications. In this example, a WebSub Subscriber service is used to implement a GitHub-based WebHook service.

::: code websub_webhook_sample.bal :::

Run the subscriber service by executing the following command.

::: out websub_webhook_sample.out :::

## Related links
- [`websub` package API documentation](https://lib.ballerina.io/ballerina/websub/latest/)
- [Subscriber service - specification](https://ballerina.io/spec/websub/#22-subscriber-service)
