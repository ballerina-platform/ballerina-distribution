# Batch execute

This BBE demonstrates how to use the MySQL client to execute a batch of
DDL/DML operations. Note that the MySQL database driver JAR should be defined in
the `Ballerina.toml` file as a dependency.
For a sample configuration and more information on the underlying module, see the [MySQL module](https://docs.central.ballerina.io/ballerinax/mysql/latest/).
The MySQL connector uses database properties from MySQL version 8.0.13 onwards. Therefore, it is
recommended to use a MySQL driver version greater than 8.0.13.<br><br>

::: code mysql_batch_execute_operation.bal :::

::: out mysql_batch_execute_operation.out :::