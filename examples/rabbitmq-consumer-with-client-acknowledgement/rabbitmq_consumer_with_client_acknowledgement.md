# RabbitMQ service - Consumer with acknowledgement

The messages are consumed from an existing queue using the Ballerina RabbitMQ message listener. The received messages are acknowledged manually.

By default, the ackMode is rabbitmq:AUTO_ACK, which will automatically acknowledge all messages once consumed.

For more information on the underlying module, see the [`rabbitmq` module](https://lib.ballerina.io/ballerinax/rabbitmq/latest).

::: code rabbitmq_consumer_with_client_acknowledgement.bal :::

::: out rabbitmq_consumer_with_client_acknowledgement.out :::
