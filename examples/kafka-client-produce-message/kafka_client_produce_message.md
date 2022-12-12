# Kafka client - Produce message

The `kafka:Producer` connects to a given Kafka server, and then sends messages to a specific topic in the server. A `kafka:Producer` is created by giving the server endpoint url. Once connected, `send` method is used to send messages to the Kafka server by providing the relevant topic and the value as the parameters. `anydata` and subtypes of `anydata` can be provided as the values, and these will be serialized using the built-in byte array serializer internally when sending to the server. Use this to send messages to a topic in the Kafka server.

::: code kafka_client_produce_message.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.

Run the program by executing the following command.

::: out kafka_client_produce_message.out :::

## Related links
- [`kafka:Producer->send` function - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/clients/Producer#send)
- [`kafka:Producer` functions - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#33-functions)
