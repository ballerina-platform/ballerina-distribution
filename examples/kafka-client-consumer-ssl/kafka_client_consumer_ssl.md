# Kafka client - Consumer SSL/TLS

This shows how the SSL encryption is done in the `kafka:Consumer`. For this to work properly, an active Kafka server must be present, and it should be configured to use SSL.

::: code kafka_client_consumer_ssl.bal :::

::: out kafka_client_consumer_ssl.out :::

## Related links
- [`kafka:SecureSocket` - API documentation](https://lib.ballerina.io/ballerinax/kafka/3.4.0/records/SecureSocket)
- [Secure client - specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#4212-secure-client)
