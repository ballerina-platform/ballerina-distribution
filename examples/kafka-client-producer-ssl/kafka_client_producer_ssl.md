# Kafka client - Producer SSL/TLS

This shows how the SSL encryption is done in the `kafka:Producer`.

>**Info:** For more information on the underlying module, see the [`kafka` module](https://lib.ballerina.io/ballerinax/kafka/latest).

::: code kafka_client_producer_ssl.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance configured to use [SSL/TLS](https://docs.confluent.io/3.0.0/kafka/ssl.html#configuring-kafka-brokers).

Run the program by executing the following command.

::: out kafka_client_producer_ssl.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out kafka_client_producer_ssl.curl.out :::

## Related links
- [`kafka:SecureSocket` record - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/records/SecureSocket)
- [Kafka secure client - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#322-secure-client)
