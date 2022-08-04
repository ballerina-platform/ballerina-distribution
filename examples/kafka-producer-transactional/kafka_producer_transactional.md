# Transactional producer

This shows how to do transactional message producing by sending
messages to Kafka brokers atomically using the `kafka:Producer` client. For
this to work properly, an active Kafka broker should be present.
<br/><br/>
For more information on the underlying module, 
see the [Kafka module](https://lib.ballerina.io/ballerinax/kafka/latest).

::: code kafka_producer_transactional.bal :::

::: out kafka_producer_transactional.out :::