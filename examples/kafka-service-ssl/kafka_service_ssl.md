# Kafka service - SSL/TLS

The `kafka:Service` receives messages from the Kafka server using the `kafka:Listener` via SSL. SSL/TLS can be enabled by configuring the `secureSocket` which requires a certificate, and the protocol name. Further, the mode of security must be configured by setting `securityProtocol` to `kafka:PROTOCOL_SSL`. Use this to connect to a Kafka server secured with SSL.

::: code kafka_service_ssl.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance configured to use [SSL/TLS](https://docs.confluent.io/3.0.0/kafka/ssl.html#configuring-kafka-brokers).

Run the program by executing the following command.

::: out kafka_service_ssl.out :::

>**Tip:** Run the Kafka client given in the [Kafka client - Producer SSL/TLS](/learn/by-example/kafka-client-producer-ssl) example to produce some messages to the topic.

## Related links
- [`kafka:SecureSocket` record - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/records/SecureSocket)
- [Kafka secure service - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#4312-secure-listener)
