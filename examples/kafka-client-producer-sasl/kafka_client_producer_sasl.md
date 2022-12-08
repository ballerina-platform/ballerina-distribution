# Kafka client - Producer SASL authentication

This shows how the SASL/PLAIN authentication is done in the `kafka:Producer`. To authenticate via SASL/PLAIN, the `kafka:AuthenticationConfiguration` must be provided along with `kafka:SecurityProtocol` as `kafka:PROTOCOL_SASL_PLAINTEXT` in the `kafka:ProducerConfiguration`. Use this when the Kafka server is secured with SASL/PLAIN.

::: code kafka_client_producer_sasl.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance configured to use the [SASL/PLAIN authentication mechanism](https://docs.confluent.io/platform/current/kafka/authentication_sasl/authentication_sasl_plain.html#sasl-plain-overview).

Run the program by executing the following command.

::: out kafka_client_producer_sasl.out :::

## Related links
- [`kafka:AuthenticationConfiguration` record - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/records/AuthenticationConfiguration)
- [Kafka client producer SASL authentication - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#322-secure-client)
