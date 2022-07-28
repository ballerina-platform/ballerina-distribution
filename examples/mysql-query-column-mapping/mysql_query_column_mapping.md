# Query with advanced mapping

This BBE demonstrates how to use the MySQL client for query operations with advanced mapping for column names.
Note that the MySQL database driver JAR should be defined in the `Ballerina.toml` file as a dependency.

For a sample configuration and more information on the underlying module, see the [MySQL module](https://docs.central.ballerina.io/ballerinax/mysql/latest/).
The MySQL connector uses database properties from MySQL version 8.0.13 onwards. Therefore, it is
recommended to use a MySQL driver version greater than 8.0.13.

::: code mysql_query_column_mapping.bal :::

::: out mysql_query_column_mapping.out :::

The following util files will initialize the test database before running the bbe and cleans it up afterwards.

::: code initialize.bal :::

::: cleanup.bal
