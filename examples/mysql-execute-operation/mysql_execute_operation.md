# MySQL client - DML and DDL operations

This BBE demonstrates how to use the MySQL client with the DDL and  DML operations. 

For more information on the underlying module, see the [`mysql` module](https://lib.ballerina.io/ballerinax/mysql/latest/).

::: code mysql_execute_operation.bal :::

Create a Ballerina project. Copy the example to the project. Execute the command below to build and run the project.

::: out mysql_execute_operation.out :::

The following util files will initialize the test database before running the BBE and clean it up afterward.

::: code initialize.bal :::

::: code cleanup.bal :::
