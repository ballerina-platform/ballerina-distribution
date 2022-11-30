# Database Access - Atomic transactions

This BBE demonstrates how to use the MySQL client to execute a batch of DDL/DML operations with the help of a `transaction` to achieve the atomic behaviour.

::: code mysql_atomic_transaction.bal :::

## Prerequisite
- Create a Ballerina project.
- Copy the example to the project along with util files.
- Change the database configurations in the files.

Run the sample by executing the following command.

::: out mysql_atomic_transaction.out :::

The syntax for using XA transactions (distributed transactions across multiple resources) is the same. Additionally, `useXADatasource` option should be enabled in the client,

::: code mysql_atomic_xa_transaction.bal :::

The following util files will initialize the test database before running the BBE and clean it up afterward.

::: code initialize.bal :::

::: code cleanup.bal :::

## Related links
- [`mysql:Client` - API documentation](https://lib.ballerina.io/ballerinax/mysql/latest/)
- [`mysql:Client` - Specification](https://github.com/ballerina-platform/module-ballerinax-mysql/blob/master/docs/spec/spec.md#2-client)
