# Database Access - Call stored procedures

The `mysql` client allows to execute a stored procedure using the `call` method. This method requires `sql:ParameterizedQuery` typed SQL CALL statement as argument.

> **Tip**: Checkout [`ballerinax/mssql`](https://central.ballerina.io/ballerinax/mssql), [`ballerinax/postgresql`](https://central.ballerina.io/ballerinax/postgresql), [`ballerinax/oracledb`](https://central.ballerina.io/ballerinax/oracledb), [`ballerinax/java.jdbc`](https://central.ballerina.io/ballerinax/java.jdbc) for other supported database clients.

::: code mysql_call_stored_procedures.bal :::

## Prerequisites
- Refer [`mysql-prerequisite`](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/mysql-prerequisite).

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
