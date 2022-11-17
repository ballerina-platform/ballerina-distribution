# Batch execution

This BBE demonstrates how to use the MySQL client to execute a batch of DDL/DML operations. 

For more information on the underlying module, see the [`mysql` module](https://lib.ballerina.io/ballerinax/mysql/latest/).

::: code mysql_batch_execute_operation.bal :::

::: out mysql_batch_execute_operation.out :::

The following util files will initialize the test database before running the BBE and clean it up afterward.

::: code initialize.bal :::

::: code cleanup.bal :::
