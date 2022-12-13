# Kafka client - Consumer SSL/TLS

This shows how the SSL encryption is done in the `kafka:Consumer`.

::: code kafka_client_consumer_ssl.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance configured to use [SSL/TLS](https://docs.confluent.io/3.0.0/kafka/ssl.html#configuring-kafka-brokers).

Run the program by executing the following command.

::: out kafka_client_consumer_ssl.out :::

>**Tip:** Run the Kafka client given in the [Kafka client - Producer SSL/TLS](/learn/by-example/kafka-client-producer-ssl) example to produce some messages to the topic.

## Related links
- [`kafka:SecureSocket` record - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/records/SecureSocket)
- [Kafka secure client - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#4212-secure-client)
