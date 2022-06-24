# SASL authentication - producer

This shows how the SASL/PLAIN authentication is done in the `kafka:Producer`.
For this to work properly, an active Kafka server must be present
and it should be configured to use the SASL/PLAIN authentication mechanism.
<br/><br/>
For more information on the underlying module,
see the [Kafka module](https://lib.ballerina.io/ballerinax/kafka/latest).

::: code kafka_authentication_sasl_plain_producer.bal :::

::: out kafka_authentication_sasl_plain_producer.out :::