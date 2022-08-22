# SASL authentication - Consumer

This shows how the SASL/PLAIN authentication is done in the `kafka:Consumer`.

For this to work properly, an active Kafka server must be present, and it should be configured to use the SASL/PLAIN authentication mechanism.

For more information on the underlying module, see the [`kafka` module](https://lib.ballerina.io/ballerinax/kafka/latest).

::: code kafka_authentication_sasl_plain_consumer.bal :::

::: out kafka_authentication_sasl_plain_consumer.out :::
