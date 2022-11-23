# MySQL client - Atomic transactions

This BBE demonstrates how to use the MySQL client to execute a batch of DDL/DML operations with the help of a `transaction` to achieve the atomic behaviour.

::: code mysql_atomic_transaction.bal :::

Create a Ballerina project. Copy the example to the project. Execute the command below to build and run the project.

::: out mysql_atomic_transaction.out :::

The syntax for using XA transactions (distributed transactions across multiple resources) is the same. Additionally, `useXADatasource` option should be enabled in the client as follows,

::: code mysql_atomic_xa_transaction.bal :::

The following util files will initialize the test database before running the BBE and clean it up afterward.

::: code initialize.bal :::

::: code cleanup.bal :::

For more information on the `mysql` package, see the [Ballerina library (API) documentation](https://lib.ballerina.io/ballerinax/mysql/latest/).
