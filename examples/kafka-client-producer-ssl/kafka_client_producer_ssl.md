# Kafka client - Producer SSL/TLS

This shows how the SSL encryption is done in the `kafka:Producer`. For this to work properly, an active Kafka server must be present, and it should be configured to use the SSL.

>**Info:** For more information on the underlying module, see the [`kafka` module](https://lib.ballerina.io/ballerinax/kafka/latest).

::: code kafka_client_producer_ssl.bal :::

Run the program by executing the following command.

::: out kafka_client_producer_ssl.out :::

## Related links
- [`kafka:SecureSocket` - API documentation](https://lib.ballerina.io/ballerinax/kafka/3.4.0/records/SecureSocket)
- [Secure client - specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#322-secure-client)
