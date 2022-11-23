# MySQL client - Simple query

This BBE demonstrates how to use the MySQL client select query operations with the stream return type. 

::: code mysql_query_operation.bal :::

Create a Ballerina project. Copy the example to the project. Execute the command below to build and run the project.

::: out mysql_query_operation.out :::

The following util files will initialize the test database before running the BBE and clean it up afterward.

::: code initialize.bal :::

::: code cleanup.bal :::

For more information on the `mysql` package, see the [Ballerina library (API) documentation](https://lib.ballerina.io/ballerinax/mysql/latest/).
