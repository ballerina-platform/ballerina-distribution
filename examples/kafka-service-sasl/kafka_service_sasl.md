# Kafka service - SASL authentication

This shows how the SASL/PLAIN authentication is used in the `kafka:Listener`. For this to work properly, an active Kafka broker should be present, and it should be configured to use the SASL/PLAIN authentication mechanism.

::: code kafka_service_sasl.bal :::

## Prerequisites
- Execute [Kafka client - Producer SSL/TLS](/learn/by-example/kafka-client-producer-ssl) example to produce some messages to the topic.

Run the program by executing the following command.

::: out kafka_service_sasl.out :::

## Related links
- [`kafka:AuthenticationConfiguration` record - API documentation](https://lib.ballerina.io/ballerinax/kafka/3.4.0/records/AuthenticationConfiguration)
- [SASL authentication - specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#4312-secure-listener)
