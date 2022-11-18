# Consumer service

This shows how the SASL/PLAIN authentication is used in the `kafka:Listener`. For this to work properly, an active Kafka broker should be present, and it should be configured to use the SASL/PLAIN authentication mechanism.

For more information on the underlying module,  see the [`kafka` module](https://lib.ballerina.io/ballerinax/kafka/latest).

::: code kafka_service_sasl.bal :::

::: out kafka_service_sasl.out :::
