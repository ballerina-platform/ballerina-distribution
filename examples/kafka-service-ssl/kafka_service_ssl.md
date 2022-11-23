# Kafka service - SSL/TLS

This shows how the SSL encryption is done in the `kafka:Listener`. For this to work properly, an active Kafka broker should be present, and it should be configured to use SSL.

::: code kafka_service_ssl.bal :::

::: out kafka_service_ssl.out :::

## Related links
- [`kafka:SecureSocket` - API documentation](https://lib.ballerina.io/ballerinax/kafka/3.4.0/records/SecureSocket)
- [Secure listener - specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#4312-secure-listener)
