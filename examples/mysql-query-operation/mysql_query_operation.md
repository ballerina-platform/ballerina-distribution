# Database Access - Simple query

The `mysql:Client` allows querying the database with the use of `query` method. This method requires a `sql:ParameterizedQuery`-typed SQL statement as the argument.

> **Tip**: Checkout [`ballerinax/mssql`](https://central.ballerina.io/ballerinax/mssql), [`ballerinax/postgresql`](https://central.ballerina.io/ballerinax/postgresql), [`ballerinax/oracledb`](https://central.ballerina.io/ballerinax/oracledb), [`ballerinax/java.jdbc`](https://central.ballerina.io/ballerinax/java.jdbc) for other supported database clients.

::: code mysql_simple_query.bal :::

## Prerequisites
- For more information, see the [Database Access Ballerina By Example - Prerequisites](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/mysql-prerequisite).

Run the service.

::: out mysql_simple_query.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out mysql_simple_query.client.out :::

## Related links
- [`mysql:Client` - API documentation](https://lib.ballerina.io/ballerinax/mysql/latest/)
- [`mysql:Client` - Specification](https://github.com/ballerina-platform/module-ballerinax-mysql/blob/master/docs/spec/spec.md#2-client)
