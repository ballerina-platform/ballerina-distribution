# WebSub service - Consume github events

GitHub webhooks provide the capability to receive notifications based on the events in a github repository. The Ballerina `websub` module can define websub-compliant webhooks which are used to receive notifications from any websub-compliant `hub` implementation. Specify the github pubsubhub API URL and the relevant event URL as the `target` parameter in `@websub:SubscriberServiceConfig` annotation. Start the `websub:SubscriberService` to receive event notifications.

::: code websub_webhook_sample.bal :::

## Prerequisites
- Internet connectivity to connect to github API.
- An active github repository to receive relevant events. 

Run the subscriber service by executing the following command.

::: out websub_webhook_sample.out :::

## Related links
- [`websub` module - API documentation](https://lib.ballerina.io/ballerina/websub/latest/)
- [Websub subscriber service - Specification](https://ballerina.io/spec/websub/#22-subscriber-service)
