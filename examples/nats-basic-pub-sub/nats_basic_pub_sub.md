# Publish/subscribe

The NATS client is used either to produce a message to a subject or consume a message from a subject.
In order to execute this example, it is required that a NATS server is up and running on its default host, port, and cluster.
For instructions on installing the NATS server,
go to [NATS Server Installation](https://docs.nats.io/nats-server/installation).<br/><br/>
This is a simple publish/subscribe messaging pattern example.
For more information on the underlying module, 
see the [NATS module](https://docs.central.ballerina.io/ballerinax/nats/latest).

::: code publisher.bal :::

::: out publisher.out :::

::: code subscriber.bal :::

::: out subscriber.out :::