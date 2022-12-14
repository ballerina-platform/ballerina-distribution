# Kafka producer - SASL authentication

The `kafka:Producer` connects to a Kafka server via SASL/PLAIN authentication and then, sends messages to the server. SASL/PLAIN authentication can be enabled by configuring the `auth`, which requires the authentication mechanism, username, and password. Further, the mode of security must be configured by setting the `securityProtocol` to `kafka:PROTOCOL_SASL_PLAINTEXT`. Use this to connect to a Kafka server secured with SASL/PLAIN.

::: code kafka_producer_sasl.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance configured to use the [SASL/PLAIN authentication mechanism](https://docs.confluent.io/platform/current/kafka/authentication_sasl/authentication_sasl_plain.html#sasl-plain-overview).

Run the program by executing the following command.

::: out kafka_producer_sasl.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out kafka_producer_sasl.curl.out :::

## Related links
- [`kafka:AuthenticationConfiguration` record - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/records/AuthenticationConfiguration)
- [Kafka client producer SASL authentication - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#322-secure-client)
