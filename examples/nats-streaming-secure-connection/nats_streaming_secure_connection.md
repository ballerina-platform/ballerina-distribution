# Secured connection

The underlying connections of the subscriber and the publisher are
secured with TLS/SSL and Basic Auth.<br/><br/>
For more information on the underlying module,
see the [STAN module](https://docs.central.ballerina.io/ballerinax/stan/latest).

::: code ./examples/nats-streaming-secure-connection/publisher.bal :::

::: out ./examples/nats-streaming-secure-connection/publisher.out :::

::: code ./examples/nats-streaming-secure-connection/subscriber.bal :::

::: out ./examples/nats-streaming-secure-connection/subscriber.out :::