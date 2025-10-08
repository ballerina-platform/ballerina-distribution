# Message Store Type

The `messaging` package in Ballerina provides messaging capabilities through the `Store` interface. This example demonstrates how to implement a custom message store by creating your own implementation of the `messaging:Store` type.

The `messaging:Store` interface defines the contract for message storage, retrieval, and acknowledgment operations. By implementing this interface, you can create custom message stores that suit your specific requirements while maintaining compatibility with the messaging framework.

::: code message_store_type.bal :::

::: out message_store_type.out :::

## Related links

- [`messaging` module - API documentation](https://lib.ballerina.io/ballerina/messaging/latest/)
- [`messaging` module - Specification](https://ballerina.io/spec/messaging/)
- [In-memory message store](/learn/by-example/in-memory-message-store/)
