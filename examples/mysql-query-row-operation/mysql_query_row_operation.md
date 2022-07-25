# Query with one result

This BBE demonstrates how to use the MySQL client select query row operations. 
Note that the MySQL database driver JAR should
be defined in the `Ballerina.toml` file as a dependency.
For a sample configuration and more information on the underlying module, see the [MySQL module](https://lib.ballerina.io/ballerinax/mysql/latest/).
The MySQL connector uses database properties from MySQL version 8.0.13 onwards. Therefore, it is
recommended to use a MySQL driver version greater than 8.0.13.<br><br>

::: code mysql_query_row_operation.bal :::

::: out mysql_query_row_operation.out :::