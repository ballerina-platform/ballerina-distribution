# Database Access - Query with advanced mapping

The `mysql:Client` allows querying the database with the use of `query` method. To map the table column name with a different Ballerina record field use the `sql:Column` annotation. 

> **Tip**: Checkout [`ballerinax/mssql`](https://central.ballerina.io/ballerinax/mssql), [`ballerinax/postgresql`](https://central.ballerina.io/ballerinax/postgresql), [`ballerinax/oracledb`](https://central.ballerina.io/ballerinax/oracledb), [`ballerinax/java.jdbc`](https://central.ballerina.io/ballerinax/java.jdbc) for other supported database clients.

::: code mysql_query_column_mapping.bal :::

## Prerequisites
- To set up the database, see the [Database Access Ballerina By Example - Prerequisites](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/mysql-prerequisite).

Run the service.

::: out mysql_query_column_mapping.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out mysql_query_column_mapping.client.out :::

## Related links
- [`mysql:Client` - API documentation](https://lib.ballerina.io/ballerinax/mysql/latest/)
- [`mysql:Client` - Specification](https://github.com/ballerina-platform/module-ballerinax-mysql/blob/master/docs/spec/spec.md#2-client)
