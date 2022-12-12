# Kafka service - SASL authentication

The Kafka service receives messages from the Kafka server using the Kafka listener via SASL/PLAIN authentication. SASL/PLAIN authentication is done by providing the `kafka:AuthenticationConfiguration` along with `kafka:SecurityProtocol` as `kafka:PROTOCOL_SASL_PLAINTEXT` in the `kafka:ConsumerConfiguration`. Use this to connect to a Kafka server secured with SASL/PLAIN.

::: code kafka_service_sasl.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance configured to use the [SASL/PLAIN authentication mechanism](https://docs.confluent.io/platform/current/kafka/authentication_sasl/authentication_sasl_plain.html#sasl-plain-overview).

Run the program by executing the following command.

::: out kafka_service_sasl.out :::

>**Tip:** Run the Kafka client given in the [Kafka client - Producer SSL/TLS](/learn/by-example/kafka-client-producer-ssl) example to produce some messages to the topic.

## Related links
- [`kafka:AuthenticationConfiguration` record - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/records/AuthenticationConfiguration)
- [Kafka service SASL authentication - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#4312-secure-listener)
