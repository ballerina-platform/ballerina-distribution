# WebSub subscriber service

Ballerina provides the capability to easily introduce subscriber services that are WebSub-compliant.
Ballerina WebSub subscribers can specify the topic and hub to which they wish to subscribe to receive notifications. 
If not specified WebSub Subscriber Services will auto generate a unique random service path segment. 
Ballerina WebSub Subscriber Services could thus be registered as WebHooks to receive event notifications.
In this example, a WebSub Subscriber service is used to implement a GitHub-based WebHook service.<br/><br/>
For more information on the underlying module, 
see the [WebSub module](https://docs.central.ballerina.io/ballerina/websub/latest/).

::: code websub_webhook_sample.bal :::

::: out websub_webhook_sample.out :::