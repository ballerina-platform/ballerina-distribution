# Database Access - Call stored procedures

This BBE demonstrates how to use the MySQL client to execute a stored procedure. 

> **Tip**: Checkout [`ballerinax/mssql`](https://central.ballerina.io/ballerinax/mssql), [`ballerinax/postgresql`](https://central.ballerina.io/ballerinax/postgresql), [`ballerinax/oracledb`](https://central.ballerina.io/ballerinax/oracledb), [`ballerinax/java.jdbc`](https://central.ballerina.io/ballerinax/java.jdbc) for other supported database clients.

::: code mysql_call_stored_procedures.bal :::

## Prerequisites
- Set up the MySQL database - Run the [prerequisite.bal](https://github.com/ballerina-platform/ballerina-distribution/blob/master/examples/mysql-call-stored-procedures/prerequisites/prerequisite.bal) file by executing the command `bal run`.

Run the service.

::: out mysql_call_stored_procedures.server.out :::

Invoke the service by executing the following cURL command in a new terminal to post a new order.

::: out mysql_call_stored_procedures.client.out :::

If the procedure returns more than one result set, then those can be accessed by using,
```ballerina
boolean isAvailable = getNextQueryResult();
```
This will return whether next result set is available and update `queryResult` with the next result set.

## Related links
- [`mysql:Client` - API documentation](https://lib.ballerina.io/ballerinax/mysql/latest/)
- [`mysql:Client` - Specification](https://github.com/ballerina-platform/module-ballerinax-mysql/blob/master/docs/spec/spec.md#2-client)
