# Kafka client - Producer SASL authentication

The Kafka producer connects to a Kafka server via SASL/PLAIN authentication, and then sends messages to the server. SASL/PLAIN authentication is done by providing the `kafka:AuthenticationConfiguration` along with `kafka:SecurityProtocol` as `kafka:PROTOCOL_SASL_PLAINTEXT` in the `kafka:ProducerConfiguration`. Use this to connect to a Kafka server secured with SASL/PLAIN.

::: code kafka_client_producer_sasl.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance configured to use the [SASL/PLAIN authentication mechanism](https://docs.confluent.io/platform/current/kafka/authentication_sasl/authentication_sasl_plain.html#sasl-plain-overview).

Run the program by executing the following command.

::: out kafka_client_producer_sasl.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out kafka_client_producer_sasl.curl.out :::

## Related links
- [`kafka:AuthenticationConfiguration` record - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/records/AuthenticationConfiguration)
- [Kafka client producer SASL authentication - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#322-secure-client)
