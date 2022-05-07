# Consumer service

Here, a Kafka consumer is used as a listener
to a service with manual offset commits.
For this to work properly, an active Kafka broker should be present.<br/><br/>
For more information on the underlying module, 
see the [`kafka` module](https://lib.ballerina.io/ballerinax/kafka/latest).

::: code ./examples/kafka-consumer-service/kafka_consumer_service.bal :::

::: out ./examples/kafka-consumer-service/kafka_consumer_service.out :::