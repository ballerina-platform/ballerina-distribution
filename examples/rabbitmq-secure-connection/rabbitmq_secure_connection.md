# Secured connection

The underlying connections of the consumer and the producer are
secured with TLS/SSL and Basic Auth.<br/><br/>
For more information on the underlying module, 
see the [RabbitMQ module](https://docs.central.ballerina.io/ballerinax/rabbitmq/latest).

::: code ./examples/rabbitmq-secure-connection/consumer.bal :::

::: out ./examples/rabbitmq-secure-connection/consumer.out :::

::: code ./examples/rabbitmq-secure-connection/producer.bal :::

::: out ./examples/rabbitmq-secure-connection/producer.out :::