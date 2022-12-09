# Database Access - Query with advanced mapping

The `mysql` client allows to query the database using the `query` method. You can use `sql:Column` annotation to map the table column name and ballerina record field. 

> **Tip**: Checkout [`ballerinax/mssql`](https://central.ballerina.io/ballerinax/mssql), [`ballerinax/postgresql`](https://central.ballerina.io/ballerinax/postgresql), [`ballerinax/oracledb`](https://central.ballerina.io/ballerinax/oracledb), [`ballerinax/java.jdbc`](https://central.ballerina.io/ballerinax/java.jdbc) for other supported database clients.

::: code mysql_query_column_mapping.bal :::

## Prerequisites
- Refer [`mysql-prerequisite`](https://github.com/ballerina-platform/ballerina-distribution/blob/master/examples/mysql-prerequisite/README.md).

Run the service.

::: out mysql_query_column_mapping.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out mysql_query_column_mapping.client.out :::

## Related links
- [`mysql:Client` - API documentation](https://lib.ballerina.io/ballerinax/mysql/latest/)
- [`mysql:Client` - Specification](https://github.com/ballerina-platform/module-ballerinax-mysql/blob/master/docs/spec/spec.md#2-client)
