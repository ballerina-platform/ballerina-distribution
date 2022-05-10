# Secured connection

In this example, the underlying connections of the subscriber and the publisher are
secured with TLS/SSL and Basic Auth.<br/><br/>
For more information on the underlying module,
see the [`nats` module](https://docs.central.ballerina.io/ballerinax/nats/latest).

::: code ./examples/nats-basic-secure-connection/publisher.bal :::

::: out ./examples/nats-basic-secure-connection/publisher.out :::

::: code ./examples/nats-basic-secure-connection/subscriber.bal :::

::: out ./examples/nats-basic-secure-connection/subscriber.out :::