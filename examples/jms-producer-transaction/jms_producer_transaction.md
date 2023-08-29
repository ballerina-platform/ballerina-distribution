# JMS message producer - Transactional producer

The `jms:MessageProducer` can become a transactional producer by `'commit'` and `'rollback` functionality of `jms:Session`. Upon successful execution of the transaction block, the `jms:Session` can commit or roll back in the case of any error. Use this to send messages atomically to a JMS provider.

::: code jms_producer_transaction.bal :::

## Prerequisites
- Start a [ActiveMQ broker](https://activemq.apache.org/getting-started) instance.

Run the program by executing the following command.

::: out jms_producer_transaction.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out jms_producer_transaction.curl.out :::

## Related links
- [`jms:Session->'commit` function - API documentation](https://lib.ballerina.io/ballerinax/java.jms/latest#Session-commit)
- [`jms:Session->'rollback` function - API documentation](https://lib.ballerina.io/ballerinax/java.jms/latest#Session-rollback)
- [`jms:Session` functions - Specification](https://github.com/ballerina-platform/module-ballerinax-java.jms/blob/master/docs/spec/spec.md#32-functions)
