# Kafka client - Consumer SSL/TLS

The `kafka:Consumer` connects to a Kafka server via SSL/TLS and then, receives payloads from the server. SSL/TLS can be enabled by configuring the `secureSocket`, which requires a certificate and the protocol name. Further, the mode of security must be configured by setting the `securityProtocol` to `kafka:PROTOCOL_SSL`. Use this to connect to a Kafka server secured with SSL/TLS.

::: code kafka_client_consumer_ssl.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance configured to use [SSL/TLS](https://docs.confluent.io/3.0.0/kafka/ssl.html#configuring-kafka-brokers).

Run the program by executing the following command.

::: out kafka_client_consumer_ssl.out :::

>**Tip:** Run the Kafka client given in the [Kafka client - Producer SSL/TLS](/learn/by-example/kafka-client-producer-ssl) example to produce some messages to the topic.

## Related links
- [`kafka:SecureSocket` record - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/records/SecureSocket)
- [Kafka secure client - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#4212-secure-client)
