# Consumer

The messages are consumed from an
existing queue using the Ballerina RabbitMQ message listener.
The Ballerina RabbitMQ connection used here can be re-used to create
multiple channels.
Multiple services consuming messages from the same queue or from
different queues can be attached to the same Listener.<br/><br/>
For more information on the underlying module, 
see the [RabbitMQ module](https://docs.central.ballerina.io/ballerinax/rabbitmq/latest).

::: code rabbitmq_consumer.bal :::

::: out rabbitmq_consumer.out :::