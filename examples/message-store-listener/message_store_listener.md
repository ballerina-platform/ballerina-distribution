# Message Store Listener

The `messaging` library provides a message store listener which polls the store at a configurable interval, dispatches messages to an attached service, and manages retries and a Dead-Letter store.

::: code message_store_listener.bal :::

Enable debug logs to see detailed information about message processing and error handling.

::: code Config.toml :::

::: out message_store_listener.out :::

## Related links

- [`messaging` module - API documentation](https://lib.ballerina.io/ballerina/messaging/latest/)
- [`messaging` module - Specification](https://ballerina.io/spec/messaging/)
