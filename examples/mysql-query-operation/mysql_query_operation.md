# MySQL client - Simple query

This BBE demonstrates how to use the MySQL client select query operations with the stream return type. 

::: code mysql_query_operation.bal :::

## Prerequisites
- Create a Ballerina project.
- Copy the example to the project along with util files.
- Run the sample by executing the command below.

::: out mysql_query_operation.out :::

The following util files will initialize the test database before running the BBE and clean it up afterward.

::: code initialize.bal :::

::: code cleanup.bal :::

## Related links
- [`mysql:Client` - API documentation](https://lib.ballerina.io/ballerinax/mysql/latest/)
- [`mysql:Client` - Specification](https://github.com/ballerina-platform/module-ballerinax-mysql/blob/master/docs/spec/spec.md#2-client)
