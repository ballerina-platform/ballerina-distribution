# Call stored procedures

This BBE demonstrates how to use the MySQL client to execute a stored procedure. 

For more information on the underlying module, see the [`mysql` module](https://lib.ballerina.io/ballerinax/mysql/latest/).

::: code mysql_call_stored_procedures.bal :::

::: out mysql_call_stored_procedures.out :::

The following util files will initialize the test database before running the BBE and clean it up afterward.

::: code initialize.bal :::

::: code cleanup.bal :::
