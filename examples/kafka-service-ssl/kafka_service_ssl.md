# Kafka service - SSL/TLS

This shows how the SSL encryption is done in the `kafka:Listener`. For this, provide `kafka:SecureSocket` with the relevant values and `kafka:SecurityProtocol` as `kafka:PROTOCOL_SSL` in the `kafka:ConsumerConfiguration`. Use this when the Kafka server is secured with SSL.

::: code kafka_service_ssl.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance configured to use [SSL/TLS](https://docs.confluent.io/3.0.0/kafka/ssl.html#configuring-kafka-brokers).
- Run the Kafka client given in the [Kafka client - Producer SSL/TLS](/learn/by-example/kafka-client-producer-ssl) example to produce some messages to the topic.

Run the program by executing the following command.

::: out kafka_service_ssl.out :::

## Related links
- [`kafka:SecureSocket` record - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/records/SecureSocket)
- [Kafka secure service - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#4312-secure-listener)
