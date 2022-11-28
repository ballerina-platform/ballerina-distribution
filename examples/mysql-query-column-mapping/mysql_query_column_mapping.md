# MySQL client - Query with advanced mapping

This BBE demonstrates how to use the MySQL client for query operations with advanced mapping for column names.

::: code mysql_query_column_mapping.bal :::

## Prerequisites
- Create a Ballerina project.
- Copy the example to the project along with util files.

Run the sample by executing the following command.

::: out mysql_query_column_mapping.out :::

The following util files will initialize the test database before running the BBE and clean it up afterward.

::: code initialize.bal :::

::: code cleanup.bal :::

## Related links
- [`mysql:Client` - API documentation](https://lib.ballerina.io/ballerinax/mysql/latest/)
- [`mysql:Client` - Specification](https://github.com/ballerina-platform/module-ballerinax-mysql/blob/master/docs/spec/spec.md#2-client)
