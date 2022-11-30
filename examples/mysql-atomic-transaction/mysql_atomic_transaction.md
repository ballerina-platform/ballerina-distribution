# Database Access - Atomic transactions

This BBE demonstrates how to use the MySQL client to execute a batch of DDL/DML operations with the help of a `transaction` to achieve the atomic behaviour.

::: code mysql_atomic_transaction.bal :::

## Prerequisite
- Set up the MySQL database - Run the [prerequisite.bal](https://github.com/ballerina-platform/ballerina-distribution/blob/master/examples/mysql-atomic-transaction/prerequisites/prerequisite.bal) file by executing the command `bal run`.

Run the sample by executing the following command.

::: out mysql_atomic_transaction.out :::

The syntax for using XA transactions (distributed transactions across multiple resources) is the same. Additionally, `useXADatasource` option should be enabled in the client,

::: code mysql_atomic_xa_transaction.bal :::

## Related links
- [`mysql:Client` - API documentation](https://lib.ballerina.io/ballerinax/mysql/latest/)
- [`mysql:Client` - Specification](https://github.com/ballerina-platform/module-ballerinax-mysql/blob/master/docs/spec/spec.md#2-client)
