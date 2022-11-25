# JDBC client - Query with advanced mapping

This BBE demonstrates how to use the JDBC  client for query operations with advanced mapping for column names.

::: code jdbc_query_column_mapping.bal :::

## Prerequisites

- Create a Ballerina project.
- Copy the example to the project along with util files.
- Add the relevant database driver JAR details to the `Ballerina.toml` file. For a sample configuration, see the [`jdbc` module](https://lib.ballerina.io/ballerinax/java.jdbc/latest/).
  >**Note:** This sample is based on an H2 database and the H2 database driver JAR needs to be added to the `Ballerina.toml` file. This sample is written using H2 2.0.6 and it is recommended to use an H2 JAR file of a version higher than 2.0.2.
- Run the sample by executing the command below.

::: out jdbc_query_column_mapping.out :::

The following util files will initialize the test database before running the BBE and clean it up afterward.

::: code initialize.bal :::

::: code cleanup.bal :::

## Related links
- [`jdbc:Client` - API documentation](https://lib.ballerina.io/ballerinax/java.jdbc/latest/)
- [`jdbc:Client` - Specification](https://github.com/ballerina-platform/module-ballerinax-java.jdbc/blob/master/docs/spec/spec.md#2-client)
