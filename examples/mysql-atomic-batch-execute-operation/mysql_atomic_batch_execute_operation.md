# Atomic transaction

This BBE demonstrates how to use the MySQL client to execute a batch of DDL/DML operations with the help of a `transaction` to achieve the atomic behaviour.

For more information on the underlying module, see the [`mysql` module](https://lib.ballerina.io/ballerinax/mysql/latest/).

::: code mysql_atomic_batch_execute_operation.bal :::

::: out mysql_atomic_batch_execute_operation.out :::

The following util files will initialize the test database before running the BBE and clean it up afterward.

::: code initialize.bal :::

::: code cleanup.bal :::
