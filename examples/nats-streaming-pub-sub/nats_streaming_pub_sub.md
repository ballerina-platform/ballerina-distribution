# Publish/subscribe

The `nats` streaming library provides the functionality of a basic publish/subscribe.
In order to run this sample, a NATS Streaming server should be
running on the corresponding port used in the sample.<br/><br/>
For more information on the underlying module, 
see the [STAN module](https://docs.central.ballerina.io/ballerinax/stan/latest).

::: code ./examples/nats-streaming-pub-sub/publisher.bal :::

::: out ./examples/nats-streaming-pub-sub/publisher.out :::

::: code ./examples/nats-streaming-pub-sub/subscriber.bal :::

::: out ./examples/nats-streaming-pub-sub/subscriber.out :::