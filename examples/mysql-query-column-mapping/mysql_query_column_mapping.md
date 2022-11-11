# Query with advanced mapping

This BBE demonstrates how to use the MySQL client for query operations with advanced mapping for column names.

For more information on the underlying module, see the [`mysql` module](https://lib.ballerina.io/ballerinax/mysql/latest/).

::: code mysql_query_column_mapping.bal :::

::: out mysql_query_column_mapping.out :::

The following util files will initialize the test database before running the BBE and clean it up afterward.

::: code initialize.bal :::

::: code cleanup.bal :::
