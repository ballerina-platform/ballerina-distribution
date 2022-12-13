# Database Access - Atomic transactions

The `mysql` client supports atomic units of work with multiple SQL statements. You can use the Ballerina `transaction` package with the `mysql` client to achieve atomic database transactions. The database makes all changes permanent when the transaction is committed or undo all changes when the transaction is rolled back.

> **Tip**: Checkout [`ballerinax/mssql`](https://central.ballerina.io/ballerinax/mssql), [`ballerinax/postgresql`](https://central.ballerina.io/ballerinax/postgresql), [`ballerinax/oracledb`](https://central.ballerina.io/ballerinax/oracledb), [`ballerinax/java.jdbc`](https://central.ballerina.io/ballerinax/java.jdbc) for other supported database clients.

::: code mysql_atomic_transaction.bal :::

## Prerequisite
- For more information, see the [Database Access Ballerina By Example - Prerequisites](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/mysql-prerequisite).

Run the service.

::: out mysql_atomic_transaction.server.out :::

Invoke the service by executing the following cURL command in a new terminal to post a new order.

::: out mysql_atomic_transaction.client.out :::

The syntax for using XA transactions (distributed transactions across multiple resources) is the same. Additionally, `useXADatasource` option should be enabled in the client,

::: code mysql_atomic_xa_transaction.bal :::

## Related links
- [`mysql:Client` - API documentation](https://lib.ballerina.io/ballerinax/mysql/latest/)
- [`mysql:Client` - Specification](https://github.com/ballerina-platform/module-ballerinax-mysql/blob/master/docs/spec/spec.md#2-client)
