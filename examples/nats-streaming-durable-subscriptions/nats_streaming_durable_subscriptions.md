# Durable subscriptions

The `nats` streaming library allows creating durable subscriptions.
Regular subscriptions remember
their position while the client is connected. If the client
disconnects, the position is lost. Durable subscriptions
remember their position even if the client is disconnected.<br/><br/>
For more information on the underlying module, 
see the [STAN module](https://docs.central.ballerina.io/ballerinax/stan/latest).

::: code ./examples/nats-streaming-durable-subscriptions/publisher.bal :::

::: out ./examples/nats-streaming-durable-subscriptions/publisher.out :::

::: code ./examples/nats-streaming-durable-subscriptions/subscriber.bal :::

::: out ./examples/nats-streaming-durable-subscriptions/subscriber.out :::