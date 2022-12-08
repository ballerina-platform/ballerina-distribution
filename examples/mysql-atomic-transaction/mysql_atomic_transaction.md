# Database Access - Atomic transactions

This BBE demonstrates how to use the MySQL client to execute a batch of DDL/DML operations with the help of a `transaction` to achieve the atomic behaviour.

> **Tip**: Checkout [`ballerinax/mssql`](https://central.ballerina.io/ballerinax/mssql), [`ballerinax/postgresql`](https://central.ballerina.io/ballerinax/postgresql), [`ballerinax/oracledb`](https://central.ballerina.io/ballerinax/oracledb), [`ballerinax/java.jdbc`](https://central.ballerina.io/ballerinax/java.jdbc) for other supported database clients.

::: code mysql_atomic_transaction.bal :::

## Prerequisite
- Refer [`mysql-prerequisite`](https://github.com/ballerina-platform/ballerina-distribution/blob/master/examples/mysql-prerequisite/README.md).

Run the service.

::: out mysql_atomic_transaction.server.out :::

Invoke the service by executing the following cURL command in a new terminal to post a new order.

::: out mysql_atomic_transaction.client.out :::

The syntax for using XA transactions (distributed transactions across multiple resources) is the same. Additionally, `useXADatasource` option should be enabled in the client,

::: code mysql_atomic_xa_transaction.bal :::

## Related links
- [`mysql:Client` - API documentation](https://lib.ballerina.io/ballerinax/mysql/latest/)
- [`mysql:Client` - Specification](https://github.com/ballerina-platform/module-ballerinax-mysql/blob/master/docs/spec/spec.md#2-client)
