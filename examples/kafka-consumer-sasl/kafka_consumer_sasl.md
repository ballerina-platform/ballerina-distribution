# Kafka consumer - SASL authentication

The `kafka:Consumer` connects to a Kafka server via SASL/PLAIN authentication and then, receives the payloads from the server. SASL/PLAIN authentication can be enabled by configuring the `auth`, which requires the authentication mechanism, username, and password. Further, the mode of security must be configured by setting the `securityProtocol` to `kafka:PROTOCOL_SASL_PLAINTEXT`. Use this to connect to a Kafka server secured with SASL/PLAIN.

::: code kafka_consumer_sasl.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance configured to use the [SASL/PLAIN authentication mechanism](https://docs.confluent.io/platform/current/kafka/authentication_sasl/authentication_sasl_plain.html#sasl-plain-overview).

Run the program by executing the following command.

::: out kafka_consumer_sasl.out :::

>**Tip:** Run the Kafka client given in the [Kafka producer - SASL authentication](/learn/by-example/kafka-producer-sasl) example to produce some messages to the topic.

## Related links
- [`kafka:AuthenticationConfiguration` record - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest#AuthenticationConfiguration)
- [Kafka client consumer SASL authentication - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#4212-secure-client)
