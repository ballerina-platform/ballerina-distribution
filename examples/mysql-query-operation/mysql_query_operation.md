# Database Access - Simple query

This BBE demonstrates how to use the MySQL client select query operations with the stream return type. 

This BBE is written in the context of an album microservice.

> **Tip**: Checkout [`ballerinax/mssql`](https://central.ballerina.io/ballerinax/mssql), [`ballerinax/postgresql`](https://central.ballerina.io/ballerinax/postgresql), [`ballerinax/oracledb`](https://central.ballerina.io/ballerinax/oracledb), [`ballerinax/java.jdbc`](https://central.ballerina.io/ballerinax/java.jdbc) for other supported database clients.

::: code mysql_simple_query.bal :::

## Prerequisites
- Set up the MySQL database - Run the [prerequisite.bal](https://github.com/ballerina-platform/ballerina-distribution/blob/master/examples/mysql-query-operation/prerequisites/prerequisite.bal) file by executing the command `bal run`.

Run the service.

::: out mysql_simple_query.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out mysql_simple_query.client.out :::

## Related links
- [`mysql:Client` - API documentation](https://lib.ballerina.io/ballerinax/mysql/latest/)
- [`mysql:Client` - Specification](https://github.com/ballerina-platform/module-ballerinax-mysql/blob/master/docs/spec/spec.md#2-client)
