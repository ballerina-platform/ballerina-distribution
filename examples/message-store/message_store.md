# Message Store

The `messaging` library provides an object type to implement a message store, which can be used to store, retrieve and acknowledge messages. Developers can implement this type with custom message brokers or databases.

Additionally it provides a in-memory message store implementation for quick testing and development.

::: code message_store.bal :::

::: out message_store.out :::

## Related links

- [`messaging` module - API documentation](https://lib.ballerina.io/ballerina/messaging/latest/)
- [`messaging` module - Specification](https://ballerina.io/spec/messaging/)
- [RabbitMQ message store](https://central.ballerina.io/ballerinax/rabbitmq/latest#MessageStore)
