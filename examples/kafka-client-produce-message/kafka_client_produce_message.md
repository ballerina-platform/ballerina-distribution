# Kafka client - Produce message

This shows how to send messages to a Kafka topic using the `kafka:Producer` client. Create the `kafka:Producer` with the default configurations and use the `send()` API by providing the relevant topic and the value as the parameters. You can provide `anydata` and subtypes of `anydata` as the values and these will be serialized using the builtin byte array serializer internally when sending to the server. Use this when you want to produce a value to a Kafka topic.

::: code kafka_client_produce_message.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.

Run the program by executing the following command.

::: out kafka_client_produce_message.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out kafka_client_produce_message.curl.out :::

## Related links
- [`kafka:Producer->send` function - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/clients/Producer#send)
- [`kafka:Producer` functions - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#33-functions)
