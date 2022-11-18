# Query with advanced mapping

This BBE demonstrates how to use the MySQL client for query operations with advanced mapping for column names.

For more information on the underlying module, see the [`mysql` module](https://lib.ballerina.io/ballerinax/mysql/latest/).

::: code mysql_query_column_mapping.bal :::

Create a Ballerina project. Copy the example to the project. Execute the command below to build and run the project.

::: out mysql_query_column_mapping.out :::

The following util files will initialize the test database before running the BBE and clean it up afterward.

::: code initialize.bal :::

::: code cleanup.bal :::
