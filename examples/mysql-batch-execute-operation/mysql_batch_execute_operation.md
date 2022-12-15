# Database Access - Batch execution

The `mysql:Client` allows executing a batch of DDL/DML statements with the use of `batchExecute` method. This method requires `sql:ParameterizedQuery[]`-typed SQL statements as arguments.

> **Tip**: Checkout [`ballerinax/mssql`](https://central.ballerina.io/ballerinax/mssql), [`ballerinax/postgresql`](https://central.ballerina.io/ballerinax/postgresql), [`ballerinax/oracledb`](https://central.ballerina.io/ballerinax/oracledb), [`ballerinax/java.jdbc`](https://central.ballerina.io/ballerinax/java.jdbc) for other supported database clients.

::: code mysql_batch_execute_operation.bal :::

## Prerequisites
- For more information, see the [Database Access Ballerina By Example - Prerequisites](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/mysql-prerequisite).

Run the service.

::: out mysql_batch_execute_operation.server.out :::

Invoke the service by executing the following cURL command in a new terminal to insert new record.

::: out mysql_batch_execute_operation.client.out :::

## Related links
- [`mysql:Client` - API documentation](https://lib.ballerina.io/ballerinax/mysql/latest/)
- [`mysql:Client` - Specification](https://github.com/ballerina-platform/module-ballerinax-mysql/blob/master/docs/spec/spec.md#2-client)
