# Durable subscriptions

The `nats` streaming library allows creating durable subscriptions. Regular subscriptions remember their position while the client is connected. If the client disconnects, the position is lost. Durable subscriptions remember their position even if the client is disconnected.

For more information on the underlying module, see the [`stan` module](https://lib.ballerina.io/ballerinax/stan/latest).

::: code publisher.bal :::

::: out publisher.out :::

::: code subscriber.bal :::

Stop the subscriber and publish some messages while it is stopped. Run the subscriber again.

All messages which had been published while the subscriber wasn't running should be received.

::: out subscriber.out :::
